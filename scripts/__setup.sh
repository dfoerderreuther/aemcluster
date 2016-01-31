#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for startup.."
until curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

sleep 10

curl http://${MONGODB1}:28017/serverStatus\?text\=1
echo "MONGODB1: ${MONGODB1}"

curl http://${MONGODB2}:28017/serverStatus\?text\=1
echo "MONGODB2: ${MONGODB2}"

curl http://${MONGODB3}:28017/serverStatus\?text\=1
echo "MONGODB3: ${MONGODB3}"

echo "Started.."

echo SETUP.sh time now: `date +"%T" `
mongo --host ${MONGODB1}:27017 <<EOF
   rs.initiate(rsconf = {_id: "aem6", members: [{_id: 0, host: "${MONGODB1}:27017"}]});
EOF
#rs.add("${MONGODB2}:27017");
#rs.addArb("${MONGODB3}:27017");
