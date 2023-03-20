#!/bin/sh

set -e

if [ ! -f "/etc/vsftpd.userlist" ]; then

	echo "[i] vsftpd not found, start initialisation."
	mkdir -p /var/run/vsftpd/empty
	mkdir -p /home/wordpress
	mkdir -p /home/info
	mkdir -p /home/portfolio

	mv /var/www/vsftpd.conf /etc/vsftpd.conf

	echo "[i] Create user $FTP_USER."
	useradd -m -s /bin/bash $FTP_USER
	echo $FTP_USER > /etc/vsftpd.userlist
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
	chown -R $FTP_USER:$FTP_USER /home/portfolio
	chown -R $FTP_USER:$FTP_USER /home/info
	usermod -g www-data $FTP_USER

	echo
	echo 'VSFTPD init process done. Ready for start up.'
	echo

	echo "exec vsftpd /etc/vsftpd.conf"
fi

exec vsftpd /etc/vsftpd.conf