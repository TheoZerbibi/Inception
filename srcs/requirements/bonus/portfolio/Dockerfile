FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add --update nodejs npm &&\
	npm install -g http-server

COPY ./site /tmp/site
COPY ./scripts/run.sh ./scripts/run.sh
RUN chmod a+x ./scripts/run.sh

ENTRYPOINT ["/scripts/run.sh"]