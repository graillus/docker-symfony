FROM php:7-cli

MAINTAINER Robin Graillon <robin.graillon@gmail.com>

RUN apt-get update \
     && apt-get install -y \
         git \
         zlib1g-dev \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libpng12-dev \
     && docker-php-ext-install \
         pdo \
         pdo_mysql \
         zip \
         gd \
     && curl -sS https://getcomposer.org/installer | php \
     && mv composer.phar /usr/local/bin/composer \
     && apt-get clean \
     && apt-get autoremove \
     && rm -r /var/lib/apt/lists/* 

COPY php.ini /usr/local/php/conf.d/symfony.ini

RUN usermod -u 1000 www-data \
     && mkdir /var/composer \
     && chown 1000:www-data /var/composer \
     && chmod g+w /var/composer

ENV COMPOSER_HOME /var/composer

WORKDIR /var/app
