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
        xdebug \
    && docker-php-ext-enable \
        opcache \
        apcu \
        xdebug \
    && apk del build-deps

# Install blackfire probe
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -f /tmp/blackfire*

# Install blackfire client
RUN mkdir -p /tmp/blackfire \
    && curl -A "Docker" -L https://blackfire.io/api/v1/releases/client/linux_static/amd64 | tar zxp -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire /usr/bin/blackfire \
    && rm -Rf /tmp/blackfire

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
