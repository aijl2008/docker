#!/usr/bin/env php
<?php
if (posix_geteuid() != 0) {
    exit("必须以root身份运行" . PHP_EOL . PHP_EOL);
}
$opts = array('http' =>
    array(
        'timeout' => 5
    )
);
if (!isset($_SERVER["argv"][1])) {
    exit("请指定部署的域名" . PHP_EOL . PHP_EOL);
}

fwrite(STDOUT, "请输入您的svn账号:");
$username = trim(fgets(STDIN));

fwrite(STDOUT, "请输入您的svn密码:");
$password = trim(fgets(STDIN));


$domain = $_SERVER["argv"][1];
echo "正在拉取域名列表" . PHP_EOL;
$context = stream_context_create($opts);
$url = 'http://deploy.artron.net:8000/domain.php';
$result = file_get_contents($url, false, $context);
$domains = json_decode($result, true);
if (!$domains || count($domains) < 1) {
    echo "没有可用的域名" . PHP_EOL;
    exit();
}
if ($domain != "all") {
    foreach ($domains as $i => $item) {
        if ($item['project'] != $domain) {
            unset($domains[$i]);
        }
    }
    if (count($domains) < 1) {
        echo $domain . "不可用" . PHP_EOL;
        exit();
    }
}
echo "正在更新 /etc/hosts " . PHP_EOL;
$commands = array();
if (gethostbynamel('packagist.artron.net') != "192.168.64.104") {
    if (strpos(file_get_contents('/etc/hosts'), 'packagist.artron.net')) {
        $commands[] = 'cat /etc/hosts | sed -r "s/.+packagist.artron.net.*/192.168.64.104 packagist.artron.net/g" > /etc/hosts';
    } else {
        $commands[] = 'echo "192.168.64.104 packagist.artron.net" >> /etc/hosts';
    }
    foreach ($commands as $command) {
        passthru($command, $errno);
        if ($errno != 0) {
            exit($errno);
        }
    }
}
echo "正在配置 .composer " . PHP_EOL;
$json = "{\"bitbucket-oauth\":{},\"github-oauth\":{},\"gitlab-oauth\":{},\"gitlab-token\":{},\"http-basic\":{\"packagist.artron.net\":{\"username\":\"deployer\",\"password\":\"deployer\"}}}";
if (!file_exists("/home/php-fpm/.composer")) {
    if (!@mkdir("/home/php-fpm/.composer")) {
        exit("创建/home/php-fpm/.composer失败" . PHP_EOL);
    }
}
if (!@file_put_contents("/home/php-fpm/.composer/auth.json", $json)) {
    exit("写入/home/php-fpm/.composer/auth.json失败" . PHP_EOL);
}

echo "正在配置运行时缓存目录" . PHP_EOL;
foreach ([
             '/data',
             '/data/webroot',
             '/data/webroot/runtimes',
             '/data/webroot/runtimes/Artron_Curl',
             '/data/webroot/runtimes/Artron_Db_Session',
             '/data/webroot/runtimes/Artron_Db_Slow'
         ] as $dir) {
    if (!file_exists($dir)) {
        if (!@mkdir($dir)) {
            exit("mkdir " . $dir . "失败" . PHP_EOL);
        }
    }
}
$commands = array();
foreach ($domains as $item) {
    $commands[$item['project']][] = "svn co --force --non-interactive --username=" . $username . " --password=" . $password . " http://192.168.64.104:8000/svn/" . $item['project'] . "/trunk/ /data/webroot/" . $item['project'];
    $commands[$item['project']][] = "chown www-data:www-data -R /data/webroot/" . $item['project'];
    if (strpos($item['project'], 'artron.net')) {
        if (strpos(file_get_contents('/etc/hosts'), $item['project'])) {
            $commands[$item['project']][] = 'cat /etc/hosts | sed -r "s/.+' . $item['project'] . '.*/127.0.0.1 ' . $item['project'] . '.artron.net/g" > /etc/hosts';
        } else {
            $commands[$item['project']][] = 'echo "127.0.0.1 ' . $item['project'] . '" >> /etc/hosts';
        }
        $commands[$item['project']][] = "cp /usr/local/nginx-1.12.2/conf/vhost/default.conf /usr/local/nginx-1.12.2/conf/vhost/" . $item['project'] . ".conf";
        $commands[$item['project']][] = 'sed -i "s/localhost/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        $commands[$item['project']][] = 'sed -i "s/default/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        $commands[$item['project']][] = 'sed -i "s/autoindex on;//g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        if ($item['framework'] == '1') {
            $root = '\/public';
        } else if ($item['framework'] == '0') {
            $root = '\/htdocs';
            $commands[$item['project']][] = "mkdir -p /data/webroot/runtimes/" . $item['project'];
            $commands[$item['project']][] = "mkdir -p /data/webroot/runtimes/" . $item['project'] . '/smarty/compile_dir';
            $commands[$item['project']][] = "mkdir -p /data/webroot/runtimes/" . $item['project'] . '/logs';
            $commands[$item['project']][] = 'sed -i "s/7113/5443/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        } else {
            $commands[$item['project']][] = 'sed -i "s/7113/5443/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
            $root = '';
        }
        $commands[$item['project']][] = 'sed -i "s/webroot;/webroot\/' . $item['project'] . $root . ';/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        if (!$root) {
            $commands[$item['project']][] = 'sed -i -r "s/try_file.+//g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        }
    }
}

foreach ($commands as $domain => $command) {
    echo "部署" . $domain . PHP_EOL;
    foreach ($command as $cmd) {
        echo ">>>" . $cmd . PHP_EOL;
        passthru($cmd, $errno);
        if ($errno != 0) {
            exit($errno);
        }
    }
}
passthru("chown php-fpm:php-fpm -R /data/webroot/runtimes");
passthru("supervisorctl restart nginx");