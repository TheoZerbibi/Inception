FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

RUN	apk update && \
	apk upgrade && \
	apk add wget

WORKDIR /app

RUN wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 && \
	chmod a+x cadvisor-v0.47.0-linux-amd64

ENTRYPOINT ["./cadvisor-v0.47.0-linux-amd64"]