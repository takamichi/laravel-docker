FROM php:7.0-fpm-alpine
RUN set -x \
    && apk add --no-cache icu-libs \
    && apk add --no-cache --virtual build-dependencies icu-dev \
    && docker-php-ext-install ftp \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && apk del --no-cache --purge build-dependencies
COPY ./ /var/www/html/
