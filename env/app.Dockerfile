FROM php:7.0-fpm-alpine

RUN set -x \
    && apk add --no-cache --update freetype-dev icu-libs libjpeg-turbo-dev libpng-dev \
    && apk add --no-cache --virtual build-deps \
        ${PHPIZE_DEPS} \
        icu-dev \
    && docker-php-ext-configure gd \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-freetype-dir=/usr/include/ \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) \
        ftp \
        gd \
        intl \
        opcache \
        pcntl \
        pdo \
        pdo_mysql \
        zip \
    && apk del --no-cache --purge build-deps \
    && mkdir -p /usr/src/php/ext

ENV XDEBUG_VERSION 2_4_1
RUN curl -fsSL "https://github.com/xdebug/xdebug/archive/XDEBUG_$XDEBUG_VERSION.zip" -o xdebug.zip \
    && unzip xdebug.zip -d /usr/src/php/ext \
    && mv /usr/src/php/ext/xdebug-XDEBUG_${XDEBUG_VERSION} /usr/src/php/ext/xdebug \
    && rm xdebug.zip \
    && docker-php-ext-configure xdebug \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) xdebug \
    && mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled

COPY env/app/php/php.ini /usr/local/etc/php/
COPY webapp/ /var/www/html/

RUN chmod -R 777 \
    bootstrap/cache/ \
    storage/

VOLUME /var/www/html/storage/logs

EXPOSE 9090
