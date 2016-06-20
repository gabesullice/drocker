<?php

$settings['hash_salt'] = file_get_contents('/var/www/private/hash_salt');
$config_directories['sync'] = '/var/www/config/sync';

// You may uncomment this once you have a database installed.
//$databases['default']['default'] = array(
//  'database' => 'drocker',
//  'username' => 'drocker',
//  'password' => 'drocker',
//  'host' => 'mysql',
//  'port' => '3306',
//  'driver' => 'mysql',
//);
