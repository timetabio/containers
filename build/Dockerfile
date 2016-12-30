FROM library/php:7.1-alpine

ENV PHPAB_VERSION "1.22.0"
ENV PHPAB_ARCHIVE phpab-${PHPAB_VERSION}.phar
ENV NODE_PATH /usr/lib/node_modules

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk add --no-cache ca-certificates wget && \
    update-ca-certificates && \
    wget -O /bin/phpab https://github.com/theseer/Autoload/releases/download/${PHPAB_VERSION}/${PHPAB_ARCHIVE} && \
    chmod +x /bin/phpab && \
    wget -O /bin/phpunit https://phar.phpunit.de/phpunit.phar && \
    chmod +x /bin/phpunit && \
    apk del wget

RUN apk add --no-cache ruby && \
    gem install --no-user-install --no-document rake

# rpmbuild
RUN apk add --no-cache rpm

# Xdebug
RUN apk add --no-cache autoconf g++ make && \
    pecl install Xdebug && \
    docker-php-ext-enable xdebug && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    rm -rf /tmp/pear && \
    apk del autoconf g++ make

RUN apk add --no-cache bash ncurses
RUN apk add --no-cache gettext
RUN apk add --no-cache git
RUN apk add --no-cache python py-pip && \
    pip install chkcrontab

# Install dependencies
RUN apk add --no-cache nodejs && \
    npm install -g \
        rollup@0.36.1 \
        rollup-plugin-babel@2.6.1 \
        rollup-plugin-uglify@1.0.1 \
        babel-plugin-external-helpers@6.8.0 \
        babel-preset-env@1.1.4 \
        standard@8.0.0 \
        "git://github.com/mishoo/UglifyJS2.git#harmony" \
        autoprefixer@6.4.1 \
        cssnano@3.7.4 \
        less@2.7.1 \
        postcss-cli@2.6.0 && \
    npm uninstall -g npm

WORKDIR /data/code
VOLUME /data/code
