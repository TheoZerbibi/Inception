#!/bin/bash -e

PERMISSIONS_OK=0

mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
		"$GF_PATHS_PROVISIONING/dashboards" \
		"$GF_PATHS_PROVISIONING/notifiers" \
		"$GF_PATHS_LOGS" \
		"$GF_PATHS_PLUGINS" \
		"$GF_PATHS_DATA"

chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"
chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

if [ ! -r "$GF_PATHS_CONFIG" ]; then
	echo "GF_PATHS_CONFIG='$GF_PATHS_CONFIG' is not readable."
	PERMISSIONS_OK=1
fi

if [ ! -w "$GF_PATHS_DATA" ]; then
	echo "GF_PATHS_DATA='$GF_PATHS_DATA' is not writable."
	PERMISSIONS_OK=1
fi

if [ ! -r "$GF_PATHS_HOME" ]; then
	echo "GF_PATHS_HOME='$GF_PATHS_HOME' is not readable."
	PERMISSIONS_OK=1
fi

if [ $PERMISSIONS_OK -eq 1 ]; then
	echo "You may have issues with file permissions, more information here: http://docs.grafana.org/installation/docker/#migration-from-a-previous-version-of-the-docker-container-to-5-1-or-later"
fi

if [ ! -d "$GF_PATHS_PLUGINS" ]; then
	mkdir "$GF_PATHS_PLUGINS"
fi

# Convert all environment variables with names ending in __FILE into the content of
# the file that they point at and use the name without the trailing __FILE.
# This can be used to carry in Docker secrets.
for VAR_NAME in $(env | grep '^GF_[^=]\+__FILE=.\+' | sed -r "s/([^=]*)__FILE=.*/\1/g"); do
	VAR_NAME_FILE="$VAR_NAME"__FILE
	if [ "${!VAR_NAME}" ]; then
		echo >&2 "ERROR: Both $VAR_NAME and $VAR_NAME_FILE are set (but are exclusive)"
		exit 1
	fi
	echo "Getting secret $VAR_NAME from ${!VAR_NAME_FILE}"
	export "$VAR_NAME"="$(< "${!VAR_NAME_FILE}")"
	unset "$VAR_NAME_FILE"
done

export HOME="$GF_PATHS_HOME"

cp /tmp/wp-static.yaml $GF_PATHS_PROVISIONING/dashboards/wp-static.yaml
cp /tmp/cadvisor.yaml $GF_PATHS_PROVISIONING/dashboards/cadvisor.yaml
cp /tmp/mariadb.yaml $GF_PATHS_PROVISIONING/datasources/mariadb.yaml
cp /tmp/prometheus.yaml $GF_PATHS_PROVISIONING/datasources/prometheus.yaml

grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install grafana-piechart-panel

exec su-exec grafana grafana-server  						\
  --homepath="$GF_PATHS_HOME"                               \
  --config="$GF_PATHS_CONFIG"                               \
  --packaging=docker                                        \
  "$@"                                                      \
  cfg:default.log.mode="console"                            \
  cfg:default.paths.data="$GF_PATHS_DATA"                   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"                   \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS"             \
  cfg:default.paths.provisioning="$GF_PATHS_PROVISIONING"
