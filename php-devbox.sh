#!/usr/bin/env bash

function install_package {
    dpkg -l $1 > /dev/null 2>&1
    INSTALLED=$?

    if [ '0' != $INSTALLED ]; then
        echo "-> installing package: $1"
        sudo apt-get -y install $1
    else
        echo "-> $1 already installed"
    fi
}

function install_php {
    if [ ! "php -v" ]; then
        echo "-> installing php-5.3.29"
        cd /usr/local/src/
        wget -nv http://php.net/distributions/php-5.3.29.tar.bz2
        tar xfj php-5.3.29.tar.bz2
        cd php-5.3.29

        echo "-> ./configure php-5.3.29"
        CONFIGURE_PHP="
            --quiet \
            --prefix=/usr/local \
            --sysconfdir=/etc/php5 \
            --with-config-file-path=/etc/php5/ \
            --with-config-file-scan-dir=/etc/php5/conf.d \
            --disable-debug \
            --enable-bcmath \
            --enable-calendar \
            --enable-dba \
            --enable-exif \
            --enable-fpm \
            --enable-gd-native-ttf \
            --enable-mbregex \
            --enable-mbstring \
            --enable-pcntl \
            --enable-shmop \
            --enable-soap \
            --enable-sockets \
            --enable-sysvmsg \
            --enable-sysvsem \
            --enable-sysvshm \
            --enable-sqlite-utf8 \
            --enable-wddx \
            --enable-zend-multibyte \
            --enable-zip \
            --with-bz2 \
            --with-curl \
            --with-curlwrappers \
            --with-gd \
            --with-jpeg-dir \
            --with-mhash \
            --with-mysql \
            --with-mysqli \
            --with-openssl \
            --with-pdo-pgsql \
            --with-pdo-mysql \
            --with-pgsql \
            --with-xmlrpc \
            --with-zlib"
        ./configure $CONFIGURE_PHP
        make
        make install
    else 
        echo '-> php 5.3.29 installed'
    fi
}

function install_composer {
    if ! [ -f "/usr/local/bin/composer" ]; then
        echo "-> installing composer"
        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
    else
        echo "-> running composer self-update"
        composer self-update
    fi
}

function install_mysql_server {
    if ! [ "which mysql-server" ]; then
        echo "-> installing mysql-server"
        sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password admin'
        sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password admin'
        sudo which mysql-server || apt-get -y install mysql-server
    fi
}

function install_nginx_config {
    if diff /usr/local/php-devbox/config/nginx/sites-available/default /etc/nginx/sites-available/default; then
        echo "-> no change in the nginx config"
    else
        echo "-> installing nginx config"
        sudo cp /usr/local/php-devbox/config/nginx/sites-available/default /etc/nginx/sites-available/default
        echo "-> reloading nginx"
        sudo service nginx reload
    fi
}

echo "-> updating apt-get"
sudo apt-get update

install_package nginx
install_mysql_server
install_package mysql-client
install_package autoconf
install_package bison
install_package re2c
install_package openssl
install_package libmysqlclient-dev
install_package libxml2-dev
install_package libxml2-dev
install_package libcurl4-openssl-dev
install_package libbz2-dev
install_package libpng12-dev
install_package libmysqlclient-dev
install_package libssl-dev
install_package libjpeg-dev
install_package libpq-dev
install_package libsasl2-dev
install_php
install_package php5-fpm
install_composer

install_nginx_config
