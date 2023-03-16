FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --no-cache \
    acl \
	wget \
    php8-session \
    php8-bz2 \
    php8-mysqli \
    php8-mysqlnd \
    php8-pgsql \
    php8-pdo_pgsql \
    php8-sqlite3 \
    php8-pdo_sqlite \
    php8-zip \
	php \
    sqlite &&\
	mkdir -p /var/www/adminer/ && \
	wget --output-document=/var/www/adminer/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

WORKDIR /var/www/adminer/
EXPOSE 7077

ENTRYPOINT ["php", "-S", "0.0.0.0:7077"]