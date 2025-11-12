FROM debian:bookworm

RUN apt update && apt upgrade && \
    apt-get install mariadb-server -y \
    openssl curl vim sudo bash && \
    rm -rf /var/lib/apt/lists/*
    
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld 

COPY tools/setup_mariadb.sh /tmp/setup_mariadb.sh

RUN chmod +x /tmp/setup_mariadb.sh

ENTRYPOINT ["/tmp/setup_mariadb.sh" ]