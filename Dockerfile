FROM php:8.0.0-apache-buster
WORKDIR /var/www/public
COPY apache.conf /etc/apache2/sites-available/weinstein.conf
COPY php.ini /usr/local/etc/php/
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    mariadb-client \
    libzip-dev \
    libpng-dev \
    zip \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo_mysql zip gd \
    && pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis \
    && a2enmod rewrite \
    && a2dissite 000-default.conf \
    && a2ensite weinstein.conf
