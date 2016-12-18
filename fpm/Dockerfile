FROM library/php:7.1.0-fpm

RUN pecl install redis && \
    docker-php-ext-enable redis && \
    rm -rf /tmp/pear

RUN apt-get update && \
    apt-get -y install libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql && \
    apt-get remove -y libpq-dev && \
    apt-get clean  && \
    rm -rf /tmp/*

RUN pecl install raphf && \
    docker-php-ext-enable raphf && \
    pecl install propro && \
    docker-php-ext-enable propro && \
    pecl install pecl_http && \
    docker-php-ext-enable http && \
    rm -rf /tmp/*

RUN docker-php-ext-install gettext && \
    rm -rf /tmp/*

COPY php/php.ini /usr/local/etc/php/

RUN mkdir -p /data
RUN touch /data/nsalog.txt

VOLUME /data/nslog.txt
