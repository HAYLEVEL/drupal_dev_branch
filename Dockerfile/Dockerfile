# Step 1: Use Ubuntu base image
FROM ubuntu:24.04

# Step 2: Install required packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    wget \
    git \
    unzip \
    zip \
    vim \
    && apt-get clean

# Install PHP and required PHP extensions
RUN apt-get install -y \
    php8.3 \
    php8.3-cli \
    php8.3-fpm \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-mysql \
    php8.3-zip \
    php8.3-curl \
    php8.3-gd \
    php8.3-opcache \
    php8.3-intl \
    php-memcache \
    php-memcached

# Step 4: Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Composer global bin to PATH
ENV PATH="$PATH:/root/.composer/vendor/bin"

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a directory for the PHP-FPM socket
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Configure PHP-FPM to listen on a Unix socket
COPY ./www.conf /etc/php/8.3/fpm/pool.d/www.conf

# Step 5: Set working directory
WORKDIR /var/www/html

# Step 3: Start PHP
CMD ["php-fpm8.3", "-F"]
