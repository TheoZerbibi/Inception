#!/bin/sh

set -e -x

if [ -z "$(ls -A /var/www/wordpress)" ]; then
	echo "[i] Wordpress not found, start dowloading."

	wp core download
else
	echo "[i] Wordpress already present, skipping dowload."
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "[i] Wordpress config not found, start configuration."

	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASSWORD --dbhost=$MYSQL_HOST
	wp db create
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWORD --role=author

	echo
	echo 'Wordpress init process done. Ready for start up.'
	echo

	echo "exec php-fpm8 --nodaemonize"
fi

exec php-fpm8 --nodaemonize