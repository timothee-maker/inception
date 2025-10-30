#!/bin/bash
set -euo pipefail

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
    
    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    temp_pid=$!
    
    echo "Waiting for MariaDB to be ready..."
    for i in {30..0}; do
        if [ -S /run/mysqld/mysqld.sock ]; then
            break
        fi
        sleep 1
    done
    
    if [ ! -S /run/mysqld/mysqld.sock ]; then
        echo "❌ MariaDB did not start properly — aborting setup."
        kill "$temp_pid" || true
        exit 1
    fi
    
    echo "✅ MariaDB is ready, configuring initial users..."
    
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL
    
    mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown
    echo "✅ MariaDB initial setup complete."
fi

echo "🚀 Starting MariaDB in foreground..."
exec mysqld --user=mysql --console