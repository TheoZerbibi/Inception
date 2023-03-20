while true
do
	netstat -uplnt | grep :3000 | grep LISTEN > /dev/null
	verifier=$?
	if [ 0 = $verifier ]
		then
			echo "Importing datasources"
			for i in /tmp/datasources/*; do \
				curl -X "POST" "http://localhost:3000/api/datasources" \
				-H "Content-Type: application/json" \
				--user ${GRAFANA_USER}:${GRAFANA_USER_PASSWORD} \
				--data-binary @$i
			done
			break
		else
			echo "Grafana is not running yet"
			sleep 5
	fi
done