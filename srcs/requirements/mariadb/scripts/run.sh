#!/bin/sh

if [ -d "/run/mysqld" ]; then
	echo "[i] mysqld already present, skipping creation"
	chown --recursive mysql:mysql /run/mysqld 
else
	echo "[i] mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown --recursive mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "[i] MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "[i] MySQL data directory not found, creating initial DBs"

	chown -R mysql:mysql /var/lib/mysql
	mariadb-install-db --rpm --datadir=/var/lib/mysql > /dev/null
	envsubst < tmp/setup_db.sql | mariadbd --bootstrap

	echo
	echo 'MySQL init process done. Ready for start up.'
	echo

	echo "exec mariadbd"
fi

exec mariadbd