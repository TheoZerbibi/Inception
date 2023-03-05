FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update openssl nginx && \
	mkdir /etc/nginx/certificates && \
	mkdir /var/www/wordpress && \
	openssl req \
		-x509 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/certificates/privkey.pem \
		-out /etc/nginx/certificates/fullchain.pem \
		-days 365 \
		-nodes \
		-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=Theo ZERIBI/UID=thzeribi' && \
	mkdir /www && \
	rm -rf /var/cache/apk/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/thzeribi.42.fr /etc/nginx/conf.d/default.conf
COPY www/index.html /var/www/wordpress/index.html

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]