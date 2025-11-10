#!/bin/bash

sleep 10
echo "=== Debut de l'initialisation de WordPress ==="

echo "En attente MariaDB..."

# Vérifier MariaDB
until mysqladmin ping -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" --silent; do
    echo "MariaDB is unavailable - sleeping"
    sleep 3
done

echo "✅ MariaDB est pret"

cd /var/www/html

# Télécharger WordPress avec WP-CLI si pas déjà présent
if [ ! -f wp-load.php ]; then
    echo "-------------------------Telechargement de Wordpress------------------------------"
    wp core download --allow-root --locale=fr_FR
fi

# Création de la configuration
if [ ! -f /var/www/html/wp-config.php ]; then    
    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
    
    echo "--------------------Le fichier wp-config.php est configure--------------------"
    
    wp user create \
        "${WP_USER2_LOGIN}" \
        "${WP_USER2_EMAIL}" \
        --user_pass="${WP_USER2_PASSWORD}" \
        --role=editor \
        --allow-root
else
    echo "-------------------Le fichier wp-config.php est deja existant-------------------------"
fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

if [ -d /var/www/html/wp-content ]; then
    chmod -R 775 /var/www/html/wp-content
fi

echo "-------------------------EXEC PHP----------------------------"
exec php-fpm8.2 -F --fpm-config /etc/php/8.2/fpm/php-fpm.conf