FROM php:7-fpm

MAINTAINER Robin Graillon <robin.graillon@gmail.com>

RUN apt-get update \
     && apt-get install -y \
         zlib1g-dev \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libpng12-dev \
     && docker-php-ext-install \
         pdo \
         pdo_mysql \
         zip \
         gd \
     && pecl install xdebug \
     && docker-php-ext-enable xdebug \
     && apt-get clean \
     && apt-get autoremove \
     && rm -r /var/lib/apt/lists/* 

COPY php.ini /usr/local/php/cond.d/symfony.ini

RUN usermod -u 1000 www-data

ENV COMPOSER_HOME /var/composer

WORKDIR /var/www
