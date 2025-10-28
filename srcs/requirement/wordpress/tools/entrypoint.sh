#!/bin/bash

# Attendre que MariaDB soit prêt
sleep 10

# Vérifier MariaDB
until mysqladmin ping -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" --silent; do
    echo "MariaDB is unavailable - sleeping"
    sleep 3
done


# Télécharger WordPress si nécessaire
if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html
    wp core download --allow-root
    
    wp config create --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost=mariadb:3306
    
    wp core install --allow-root \
        --url="$WP_PATH" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL"
        --locale=fr_FR
    
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PWD" \
        --allow-root
fi

# Fixer les permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Démarrer PHP-FPM
exec php-fpm8.2 -F