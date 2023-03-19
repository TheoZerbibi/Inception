FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --no-cache mariadb mariadb-client mariadb-server-utils gettext && \
	rm -f /var/cache/apk/*

COPY conf/my.cnf /etc/mysql/my.cnf
COPY scripts/run.sh /scripts/run.sh
COPY scripts/init_db.sql /scripts/init_db.sql
RUN chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/run.sh"]