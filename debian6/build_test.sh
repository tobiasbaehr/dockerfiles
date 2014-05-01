#!/bin/bash
rm ~/.ssh/known_hosts 2>/dev/null
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi tobiasb/rb-drupal6
docker build -t tobiasb/rb-drupal6 .
docker run -d -p 49101:22 -p 8081:80 -v /vagrant_data/build_test:/var/www/ tobiasb/rb-drupal6
#docker run -i -t tobiasb/rb-drupal6 /bin/bash
sleep 2
ssh dev@localhost -p 49101