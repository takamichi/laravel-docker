FROM php:7.0-fpm-alpine
RUN set -x \
    && apk add --update --no-cache icu-libs libmemcached-dev zlib-dev \
    && apk add --no-cache --virtual build-dependencies icu-dev \
    && docker-php-ext-install ftp \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/php7.zip' -o memcached.zip \
    && unzip memcached.zip -d /usr/src/php/ext \
    && mv /usr/src/php/ext/php-memcached-php7 /usr/src/php/ext/memcached \
    && rm memcached.zip \
    && docker-php-ext-configure memcached --disable-memcached-sasl \
    && docker-php-ext-install memcached \
    && apk del --no-cache --purge build-dependencies
COPY env/php/php.ini /usr/local/etc/php/
COPY webapp/ /var/www/html/
RUN chmod -R 777 /var/www/html/bootstrap/cache/ /var/www/html/storage/
VOLUME /var/www/html/storage/logs