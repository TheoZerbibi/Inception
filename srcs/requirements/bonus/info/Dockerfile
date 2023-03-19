FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update nodejs npm yarn shadow && \
	npm install -g npm@latest pnpm typescript && \
	mkdir -p /usr/src/app/info/ && \
	groupmod www-data && \
	useradd --home-dir /home/www-data --create-home --no-user-group --system www-data && \
	chown --recursive www-data:www-data usr/src/app/info/ && \
	chmod 755 -R usr/src/app/info/

COPY ./site /tmp/site
COPY ./scripts/run.sh /scripts/run.sh
RUN chmod a+x /scripts/run.sh

WORKDIR /usr/src/app/info/

ENTRYPOINT ["/scripts/run.sh"]