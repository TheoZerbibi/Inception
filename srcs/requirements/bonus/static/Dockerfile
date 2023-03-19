FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update nodejs npm yarn && \
	npm install -g npm@latest pnpm typescript && \
	mkdir -p /usr/src/app/static

COPY site/package.json /usr/src/app/static/package.json

RUN cd /usr/src/app/static/ && pnpm install

COPY ./site /usr/src/app/static/

WORKDIR /usr/src/app/static/
EXPOSE 4242

ENTRYPOINT ["pnpm", "start"]
# ENTRYPOINT [ "tail", "-f", "/dev/null" ]