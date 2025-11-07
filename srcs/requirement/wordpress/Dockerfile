FROM debian:bookworm

RUN apt update && apt install -y \
    wget php8.2 php-fpm php-mysql curl bash && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.8.2-fr_FR.tar.gz && \
    rm wordpress-6.8.2-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress
RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]