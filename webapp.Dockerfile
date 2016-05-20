FROM php:7.0-fpm-alpine
RUN set -x \
    && apk add --update --no-cache icu-libs \
    && apk add --no-cache --virtual build-dependencies icu-dev \
    && docker-php-ext-install ftp \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && apk del --no-cache --purge build-dependencies
ENV XDEBUG_VERSION 2_4_0
RUN curl -fsSL "https://github.com/xdebug/xdebug/archive/XDEBUG_$XDEBUG_VERSION.zip" -o xdebug.zip \
    && unzip xdebug.zip -d /usr/src/php/ext \
    && mv /usr/src/php/ext/xdebug-XDEBUG_${XDEBUG_VERSION} /usr/src/php/ext/xdebug \
    && rm xdebug.zip \
    && docker-php-ext-configure xdebug \
    && docker-php-ext-install xdebug
COPY env/php/php.ini /usr/local/etc/php/
COPY webapp/ /var/www/html/
RUN chmod -R 777 /var/www/html/bootstrap/cache/ /var/www/html/storage/
VOLUME /var/www/html/storage/logs