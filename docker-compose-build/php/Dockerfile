FROM php:8.3-fpm

# Install necessary PHP extensions for Drupal
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

# Install Composer (Optional: If you need Composer for managing Drupal dependencies)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
