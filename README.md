# aemcluster

Please copy cq-quickstart-6.1.0.jar and license.properties to aem/files/.

## Run the full setup with mongo cluster:

    docker-compose up

This will boot up a mongo cluster with three nodes (primary, secondary and arbiter), an aem author instance which connects to the mongo cluster, one aem publish instance and one apache dispatcher. The first boot up takes a while.

#### or if you already have a backup of the database, you can start db and aem separately and restore the backup:

Boot up mongo cluster

    docker-compose -f docker-compose-mongo.yml up

Optional:

    mongorestore --host docker --port 27017 backup/
    
Boot up aem with mongo configuration

    docker-compose -f docker-compose-aem-mongo.yml up


## Run aem with default tar datastore:

    docker-compose -f docker-compose-aem-tar.yml up

This will boot up one author instance, one publish instance and one dispatcher.

## init replication:

    curl --data transportUri=http://aempub:4503/bin/receive?sling:authRequestLogin=1 --user admin:admin http://docker:4502/etc/replication/agents.author/publish/jcr%3Acontent

### update dispatcher flush address

docker-compose can't set ip of dispatcher inside of aempub because a link cycle is not possible.

    curl --data transportUri=http://172.17.0.8:80/dispatcher/invalidate.cache --user admin:admin http://docker:4502/etc/replication/agents.publish/flush/jcr%3Acontent
    curl -u admin:admin -X POST -F path="/etc/replication/agents.publish/flush" -F cmd="activate" http://docker:4502/bin/replicate.json


## mongo

mongo status:

    mongo docker:27017 --eval 'rs.status();'

mongo backup:

    mongodump --host docker --port 27017 --out backup/

or

    mongorestore --host docker --port 27017 backup/


## bash:

    docker exec -it aemcluster_mongo1_1 bash
    docker exec -it aemcluster_mongo2_1 bash
    docker exec -it aemcluster_mongo3_1 bash
    docker exec -it aemcluster_dispatcher_1 bash
    docker exec -it aemcluster_aempub_1 bash
    docker exec -it aemcluster_aemaut_1 bash
