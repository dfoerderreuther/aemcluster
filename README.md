# aemcl

mongo status:

  mongo docker:27017 --eval 'rs.status();'

mongo backup:

  mongodump --host docker --port 27017 --out backup/

  mongorestore --host docker --port 27017 backup/
