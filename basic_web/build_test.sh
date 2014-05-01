#!/bin/bash
rm ~/.ssh/known_hosts 2>/dev/null
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi tobiasb/rb-basic-web
docker build -t tobiasb/rb-basic-web .
docker run -d -p 49102:22 -p 8082:80 -v /vagrant_data/build_test:/var/www/ tobiasb/rb-basic-web
sleep 2
ssh dev@localhost -p 49102