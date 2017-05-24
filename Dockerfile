FROM php:7.1-fpm

MAINTAINER Vitalijs Litvinovs <dev@codin.pro>

ARG PHALCON_VERSION
ENV PHALCON_VERSION=3.1.2

RUN curl -O https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION}
RUN tar xvzf v${PHALCON_VERSION}
RUN cd cphalcon-${PHALCON_VERSION}/build && ./install
RUN cd ../../ && rm -Rf cphalcon-${PHALCON_VERSION} && rm -Rf v${PHALCON_VERSION}
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini

RUN apt-get update && apt-get install -y libmcrypt-dev libxml2-dev libssl-dev libcurl4-gnutls-dev

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install curl
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install zip
RUN docker-php-ext-install ftp
RUN docker-php-ext-install sockets
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install opcache

RUN apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php5 /etc/php/5* /usr/lib/php/20121212 /usr/lib/php/20131226

RUN rm -rf /var/log /var/cache
