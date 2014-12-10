FROM reinblau/cmd

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN echo "deb http://ftp2.de.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list;\
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq git/wheezy-backports

RUN npm install ungit -g

ADD start.bash /home/dev/start.bash

EXPOSE 8448
