#!/usr/bin/env php
<?php
if (posix_geteuid() != 0) {
    exit("必须以root身份运行");
}
$opts = array('http' =>
    array(
        'timeout' => 5
    )
);
$commands = array();
if (gethostbynamel('packagist.artron.net') != "192.168.64.104") {
    if (strpos(file_get_contents('/etc/hosts'), 'packagist.artron.net')) {
        $commands[] = 'sed -i -r "s/.+packagist.artron.net.*/192.168.64.104 packagist.artron.net/g" /etc/hosts';
    } else {
        $commands[] = 'echo "192.168.64.104 packagist.artron.net" >> /etc/hosts';
    }
    foreach ($commands as $command) {
        passthru($command);
    }
}
$json = "{\"bitbucket-oauth\":{},\"github-oauth\":{},\"gitlab-oauth\":{},\"gitlab-token\":{},\"http-basic\":{\"packagist.artron.net\":{\"username\":\"deployer\",\"password\":\"deployer\"}}}";
if (!file_exists("/home/acura/.composer")) {
    mkdir("/home/acura/.composer", '0755', true);
}
file_put_contents("/home/acura/.composer/auth.json", $json);
$context = stream_context_create($opts);
$url = 'http://deploy.artron.net:8000/domain.php';
$result = file_get_contents($url, false, $context);
$commands = array();
foreach (json_decode($result, true) as $item) {
    $commands[$item['project']][] = "svn export --force --non-interactive --username=deployer --password=deployer http://192.168.64.104:8000/svn/" . $item['project'] . "/trunk/ /data/webroot/" . $item['project'];
    $commands[$item['project']][] = "chown www-data:www-data -R /data/webroot/" . $item['project'];
    if (strpos($item['project'], 'artron.net')) {
        if (strpos(file_get_contents('/etc/hosts'), $item['project'])) {
            $commands[$item['project']][] = 'sed -i -r "s/.+' . $item['project'] . '.*/127.0.0.1 ' . $item['project'] . '.artron.net/g" /etc/hosts';
        } else {
            $commands[$item['project']][] = 'echo "127.0.0.1 ' . $item['project'] . '" >> /etc/hosts';
        }
        $commands[$item['project']][] = "mkdir -p /data/webroot/runtimes/" . $item['project'];

        $commands[$item['project']][] = "cp /usr/local/nginx-1.12.2/conf/vhost/default.conf /usr/local/nginx-1.12.2/conf/vhost/" . $item['project'] . ".conf";
        $commands[$item['project']][] = 'sed -i "s/localhost/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        $commands[$item['project']][] = 'sed -i "s/default/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        $commands[$item['project']][] = 'sed -i "s/autoindex on;//g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
        if ($item['framework'] == '1') {
            $root = '\/public';
        } else if ($item['framework'] == '0') {
            $root = '\/htdocs';
        } else {
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
        echo $cmd . PHP_EOL;
        passthru($cmd);
    }
}
foreach ([
             '/data/webroot/runtimes/Artron_Curl',
             '/data/webroot/runtimes/Artron_Db_Session',
             '/data/webroot/runtimes/Artron_Db_Slow'
         ] as $dir) {
    if (!file_exists($dir)) {
        mkdir($dir, '0755', true);
    }
}

passthru("chown php-fpm:php-fpm -R /data/webroot/runtimes");
?>