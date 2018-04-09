#!/bin/bash
set -e

cd /data/src
curl -sS https://getcomposer.org/installer | /usr/local/php-5.4.43/bin/php
mv composer.phar /usr/local/bin/composer
composer global config -g repo.packagist composer https://packagist.phpcomposer.com
composer global config secure-http false
su php-fpm -c "composer global config -g repo.packagist composer https://packagist.phpcomposer.com"
su php-fpm -c "composer global config secure-http false"

