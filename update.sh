#!/usr/bin/env bash
set -o errexit
#set -x
set -o nounset

if [ "$(docker images |grep reinblau/solr3)" ];then
  docker pull reinblau/solr3
fi

if [ "$(docker images |grep reinblau/cmd)" ];then
  docker pull reinblau/cmd
fi

if [ "$(docker images |grep reinblau/phpmyadmin)" ];then
  docker pull reinblau/phpmyadmin
fi

if [ "$(docker images |grep mysql)" ];then
  docker pull mysql:5.5
fi

if [ "$(docker images |grep mariadb)" ];then
  docker pull mariadb:10.0
fi

if [ "$(docker images |grep reinblau/ungit)" ];then
  docker pull reinblau/ungit
fi
