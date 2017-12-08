FROM php:7.1-apache-jessie
COPY apache.conf /etc/apache2/sites-available/wiwu.conf
COPY ports.conf /etc/apache2/ports.conf
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    mysql-client \
    && docker-php-ext-install mcrypt pdo_mysql \
    && a2enmod rewrite \
    && a2dissite 000-default.conf \
    && a2ensite wiwu.conf
WORKDIR /var/www
USER www-data
RUN chown -R www-data:www-data /var/run/apache2 \
    && chmod -R u+rwx /var/run/apache2
EXPOSE 8080

