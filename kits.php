#!/usr/bin/env php
<?php
$opts = array('http' =>
  array(
    'timeout' => 5
  )
);
                        
$context  = stream_context_create($opts);
$url = 'http://deploy.artron.net:8000/domain.php';
$result = file_get_contents($url, false, $context);
$commands = array();
foreach(json_decode($result, true) as $item){
	$commands[$item['project']][] = "svn co --username=deployer --password=deployer http://192.168.64.104:8000/svn/" . $item['project'] . "/trunk/ /data/webroot/" . $item['project'];
	$commands[$item['project']][] = "cp /usr/local/nginx-1.12.2/conf/vhost/default.conf /usr/local/nginx-1.12.2/conf/vhost/" . $item['project'] . ".conf";
	if (strpos($item['project'], 'artron.net')){
		$commands[$item['project']][] = 'sed -i "s/localhost/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
		$commands[$item['project']][] = 'sed -i "s/default/' . $item['project'] . '/g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
		if ($item['framework'] == '1'){
			$root = '\/public';	
		}
		else if ($item['framework'] == '0'){
			$root = '\/htdocs';	
		}
		else{
			$root = '';
		}	
    		if (!$root){
			$commands[$item['project']][]  = 'sed -i -r "s/try_file.+//g" /usr/local/nginx-1.12.2/conf/vhost/' . $item['project'] . '.conf';
		}
	}
}

foreach ($commands as $domain => $command){
	echo "部署" . $domain . PHP_EOL;
	foreach ($command as $cmd){
		echo $cmd . PHP_EOL;		
//		passthru($command);
        }
}
?>
