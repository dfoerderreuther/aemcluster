# aemcl

**General: Please rename the cloned directory from aemcl to aemcluster. Otherwise docker-compose will use "aemcl" as project name and the following commands will not work without changing.**

## mongo cluster:

  docker-compose up

### or if you already have a backup of the database:

  docker-compose -f docker-compose-mongo.yml up

Optional:

  mongorestore --host docker --port 27017 backup/

  docker-compose -f docker-compose-aem-mongo-cluster.yml up



## tar cluser:

  docker-compose -f docker-compose-aem-tar-cluster.yml up


## init replication:

  curl --data transportUri=http://aempub:4503/bin/receive?sling:authRequestLogin=1 --user admin:admin http://docker:4502/etc/replication/agents.author/publish/jcr%3Acontent

### update dispatcher flush address

docker-compose can't set ip of dispatcher in aempub because a link cycle is not possible.

  curl --data transportUri=http://172.17.0.8:80/dispatcher/invalidate.cache --user admin:admin http://docker:4502/etc/replication/agents.publish/flush/jcr%3Acontent

  curl -u admin:admin -X POST -F path="/etc/replication/agents.publish/flush" -F cmd="activate" http://docker:4502/bin/replicate.json


## mongo

mongo status:

  mongo docker:27017 --eval 'rs.status();'

mongo backup:

  mongodump --host docker --port 27017 --out backup/

  mongorestore --host docker --port 27017 backup/

## bash:

  docker exec -it aemcluster_mongo1_1 bash
  docker exec -it aemcluster_mongo2_1 bash
  docker exec -it aemcluster_mongo3_1 bash
  docker exec -it aemcluster_dispatcher_1 bash
  docker exec -it aemcluster_aempub_1 bash
  docker exec -it aemcluster_aemaut_1 bash
