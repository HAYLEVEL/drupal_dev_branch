In your settings.php, you can include the files with necessary configurations
Just add to settings.php this code.


/ Include Memcache settings if the file exists.
For additional flexibility, you can use environment variables in your settings.memcache.php file to store sensitive values like server addresses, ports, and key prefixes.
__________________________________________________________________
$memcache_settings_file = __DIR__ . '/memcache.php';
if (file_exists($memcache_settings_file)) {
    include $memcache_settings_file;
}
___________________________________________________________________




/ Include Configuration Split settings if the file exists.
___________________________________________________________________
$config_split_settings_file = __DIR__ . '/config_split.php';
if (file_exists($config_split_settings_file)) {
    include $config_split_settings_file;
}
___________________________________________________________________
