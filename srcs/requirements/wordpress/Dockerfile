FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

WORKDIR /var/www/wordpress/

RUN	apk update && \
	apk upgrade && \
	apk add fcgi wget php8 php8-fpm php8-phar php8-iconv php8-mysqli mariadb-client shadow && \
	wget --output-document=/usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp && \
	php8_location=$(which php8) && \
	groupmod www-data && \
	useradd --home-dir /home/www-data --create-home --no-user-group --system www-data && \
	chown --recursive www-data:www-data /var/www/wordpress/ /var/log/php8 && \
	chmod -R 755 /var/www/wordpress/ && \
	rm -rf /var/cache/apk/*

COPY conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY scripts/init.sh /scripts/init.sh

RUN chmod -R 755 /scripts

EXPOSE 9000
USER www-data

ENTRYPOINT ["/scripts/init.sh"]