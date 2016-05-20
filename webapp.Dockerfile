FROM php:7.0-fpm-alpine
RUN set -x \
    && apk add --update --no-cache icu-libs \
    && apk add --no-cache --virtual build-dependencies icu-dev \
    && docker-php-ext-install ftp \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && curl -fsSL 'https://github.com/xdebug/xdebug/archive/XDEBUG_2_4_0.zip' -o xdebug.zip \
    && unzip xdebug.zip -d /usr/src/php/ext \
    && mv /usr/src/php/ext/xdebug-XDEBUG_2_4_0 /usr/src/php/ext/xdebug \
    && rm xdebug.zip \
    && docker-php-ext-configure xdebug \
    && docker-php-ext-install xdebug \
    && apk del --no-cache --purge build-dependencies
COPY env/php/php.ini /usr/local/etc/php/
COPY webapp/ /var/www/html/
RUN chmod -R 777 /var/www/html/bootstrap/cache/ /var/www/html/storage/
VOLUME /var/www/html/storage/logs