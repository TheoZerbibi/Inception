FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update nodejs npm yarn && \
	npm install -g npm@latest pnpm typescript && \
	mkdir -p /usr/src/app/info

COPY site/package.json /usr/src/app/info/package.json

RUN cd /usr/src/app/info/ && pnpm install

COPY ./site /usr/src/app/info/

WORKDIR /usr/src/app/info/

ENTRYPOINT ["pnpm", "start"]