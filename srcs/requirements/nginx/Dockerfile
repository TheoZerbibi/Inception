FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update openssl nginx && \
	mkdir /etc/nginx/certificates && \
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
COPY www/index.html /var/www/



ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
# RUN apk update && apk upgrade \
# 	&& apk add \
# 		nginx \
# 		openssl
# RUN mkdir -p /etc/nginx/ssl/live/thzeribi.42.fr /var/run/nginx /var/www/nginx \
# 	&& openssl req -x509 -nodes -subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=Theo ZERIBI/UID=thzeribi' -out '/etc/nginx/ssl/live/thzeribi.42.fr/fullchain.crt' -keyout '/etc/nginx/ssl/live/thzeribi.42.fr/privkey.key' \
# 	&& chown --recursive nginx:nginx /etc/nginx /run/nginx /var/run/nginx /var/lib/nginx /var/www/nginx \
# 	&& chmod -R 755 /var/www/nginx

# RUN touch /run/nginx.pid \
#  && chown -R nginx:nginx /run/nginx.pid \
#  && chmod 777 /run/nginx.pid

# COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY conf/thzeribi.42.fr /etc/nginx/sites-enabled/thzeribi.42.fr
# COPY www/index.html /var/www/

# USER nginx
# EXPOSE 443

# CMD ["nginx", "-g", "daemon off;"]
# ==============================================================
# FROM alpine:3.16

# RUN \
# apk update && \
# apk upgrade && \
# apk add \
# 	shadow \
# 	&& \
# apk add \
# 	nginx \
# 	openssl \
# 	&& \
# mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/nginx && \
# openssl req -x509 -nodes -subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42paris/CN=Jonathan DUFOUR/UID=jodufour' -out '/etc/nginx/ssl/inception.crt' -keyout '/etc/nginx/ssl/inception.key' && \
# chown --recursive nginx:nginx /etc/nginx /run/nginx /var/run/nginx /var/lib/nginx /var/www/nginx && \
# chmod -R 755 /var/www/nginx

# RUN touch /run/nginx.pid \
#  && chown -R nginx:nginx /run/nginx.pid

# COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY conf/thzeribi.42.fr /etc/nginx/sites-enabled/thzeribi.42.fr

# EXPOSE 443

# USER nginx

# CMD ["nginx", "-g", "daemon off;"]