#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "Waiting for startup of mongo1.."
until curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

echo "Waiting for startup of mongo2.."
until curl http://${MONGODB2}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

echo "Waiting for startup of mongo3.."
until curl http://${MONGODB2}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

echo "MONGODB1: ${MONGODB1}"
echo "MONGODB2: ${MONGODB2}"
echo "MONGODB3: ${MONGODB3}"

mongo --host ${MONGODB1}:27017 <<EOL
   var cfg = {
        "_id": "aem6",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "${MONGODB1}:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "${MONGODB2}:27017",
                "priority": 1
            },
            {
                "_id": 2,
                "host": "${MONGODB3}:27017",
                "priority": 2,
                arbiterOnly: true
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOL

echo "Done."
