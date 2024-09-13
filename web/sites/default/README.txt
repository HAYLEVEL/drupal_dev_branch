In your settings.php, you can include the settings.memcache.php file.
Just add to settings.php this code.


/ Include Memcache settings if the file exists.
__________________________________________________________________
$memcache_settings_file = __DIR__ . '/memcache.php';
if (file_exists($memcache_settings_file)) {
    include $memcache_settings_file;
}
___________________________________________________________________


For additional flexibility, you can use environment variables in your settings.memcache.php file to store sensitive values like server addresses, ports, and key prefixes.
