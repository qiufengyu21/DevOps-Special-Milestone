#!/bin/bash
export MONGO_IP=127.0.0.1
export MONGO_PORT=3002
export MONGO_USER=admin
export MONGO_PASSWORD=admin123
service mongodb restart
service nginx restart
mongo admin --eval "db.createUser({user:'admin',pwd:'admin123',roles:[{role:'root',db:'admin'}]});"
cd /checkbox.io/server-side/site && node server.js
