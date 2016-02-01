#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for startup.."
until curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

mongo ${MONGODB1}:27017 --eval "rs.initiate(rsconf = {_id: \"aem6\", members: [{_id: 0, host: \"${MONGODB1}:27017\"}]})"
mongo ${MONGODB1}:27017 --eval "rs.add(\"${MONGODB2}:27017\")"
mongo ${MONGODB1}:27017 --eval "rs.addArb(\"${MONGODB3}:27017\")"

echo "Done."