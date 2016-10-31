<?php

$databases['default']['default'] = array(
  'database' => 'drocker',
  'username' => 'drocker',
  'password' => 'drocker',
  'host' => 'mysql',
  'port' => '3306',
  'driver' => 'mysql',
);

$config_directories['sync'] = '/var/www/config/sync';

$settings['hash_salt'] = file_get_contents('/var/www/private/hash_salt.txt');
$settings['install_profile'] = 'standard';
$settings['file_private_path'] = '/var/www/private';
