<?php

$databases['default']['default'] = array (
  'database' => 'drupal',
  'username' => 'drupaluser',
  'password' => 'drupall_pass',
  'prefix' => '',
  'host' => '10.50.112.3',
  'port' => '3306',
  'isolation_level' => 'READ COMMITTED',
  'driver' => 'mysql',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
);
