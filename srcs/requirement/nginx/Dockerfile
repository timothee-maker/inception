FROM debian:bookworm

RUN apt update && apt upgrade && \
    apt install nginx -y \
    openssl curl vim sudo bash

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048\
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=tnolent.42.fr/UID=tnolent"

RUN mkdir -p /var/run/nginx

COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]