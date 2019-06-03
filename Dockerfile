FROM php:7.1.30-apache-jessie
WORKDIR /var/www/public
COPY apache.conf /etc/apache2/sites-available/weinstein.conf
COPY php.ini /usr/local/etc/php/
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    mysql-client \
    libzip-dev \
    zip \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install pdo_mysql zip \
    && a2enmod rewrite \
    && a2dissite 000-default.conf \
    && a2ensite weinstein.conf
