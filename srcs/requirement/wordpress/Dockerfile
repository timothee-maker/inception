FROM debian:bookworm

RUN apt update && apt upgrade -y && \
    apt install -y \
    php \
    php-fpm \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    wget \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Installer le CLI de wordpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configurer PHP-FPM pour écouter sur 9000
RUN sed -i 's|listen = /run/php/php-fpm.sock|listen = 9000|' /etc/php//fpm/pool.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/' /etc/php//fpm/pool.d/www.conf

RUN mkdir -p /var/www/html /run/php && \
    chown -R www-data:www-data /var/www/html /run/php

WORKDIR /var/www/html

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
    
CMD ["/entrypoint.sh"]