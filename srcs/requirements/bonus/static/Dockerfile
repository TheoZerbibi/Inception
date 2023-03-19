FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update nodejs npm yarn && \
	npm install -g npm@latest pnpm typescript

WORKDIR /usr/src/app/static
EXPOSE 4242

ENTRYPOINT ["tail", "-f", "/dev/null"]