FROM php:7.4-cli
RUN apt-get update && apt-get install -y zip git
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer
WORKDIR /var/www/app
COPY composer.json composer.lock ./
RUN composer install
