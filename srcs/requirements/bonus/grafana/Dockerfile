FROM alpine:3.16

LABEL maintainer="Theo ZERIBI <thzeribi@student.42.fr>"

ENV GRAFANA_VERSION=9.4.3

ARG GRAFANA_USER=GRAFANA_USER

RUN mkdir /tmp/grafana \
	&& wget -P /tmp/ https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
	&& tar xfz /tmp/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz --strip-components=1 -C /tmp/grafana

ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
	GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
	GF_PATHS_DATA="/var/lib/grafana" \
	GF_PATHS_HOME="/usr/share/grafana" \
	GF_PATHS_LOGS="/var/log/grafana" \
	GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
	GF_PATHS_PROVISIONING="/etc/grafana/provisioning" \
	GF_SECURITY_ADMIN_USER=${GRAFANA_USER}

WORKDIR $GF_PATHS_HOME

RUN set -ex \
	&& addgroup -S grafana \
	&& adduser -S -G grafana grafana \
	&& apk add --no-cache libc6-compat ca-certificates su-exec bash \
	&& cp -r /tmp/grafana/* "$GF_PATHS_HOME"

RUN mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
		"$GF_PATHS_PROVISIONING/dashboards" \
		"$GF_PATHS_PROVISIONING/notifiers" \
		"$GF_PATHS_LOGS" \
		"$GF_PATHS_PLUGINS" \
		"$GF_PATHS_DATA" \
	&& chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" \
	&& chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

COPY ./conf/grafana.ini "$GF_PATHS_CONFIG"
COPY ./scripts/run.sh /scripts/run.sh
RUN chmod a+x /scripts/run.sh

EXPOSE 3000
ENTRYPOINT ["/scripts/run.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]