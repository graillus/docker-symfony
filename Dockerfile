FROM composer:latest as composer
FROM php:7.2-fpm-alpine

LABEL maintainer="Robin Graillon <robin.graillon@gmail.com>"

RUN apk add --no-cache --virtual persistent-deps \
        git \
        icu-libs \
        zlib

RUN apk add --no-cache --virtual build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
    && docker-php-ext-install \
        opcache \
        intl \
        zip \
    && pecl install \
        apcu \
        xdebug-alpha \
    && docker-php-ext-enable \
        opcache \
        apcu \
        xdebug \
    && apk del build-deps

COPY docker/php-fpm/php.ini /usr/local/etc/php/php.ini
COPY docker/php-fpm/conf.d/ /usr/local/etc/php/conf.d/

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN mkdir /var/composer
ENV COMPOSER_HOME /var/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative  --no-interaction

COPY . /var/www/app

ENV APP_ENV dev
ENV APP_SECRET ${APP_SECRET}

WORKDIR /var/www/app
