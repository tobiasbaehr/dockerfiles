FROM reinblau/cmd

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq git/wheezy-backports

RUN npm install -g ungit

ADD start.bash /home/dev/start.bash

EXPOSE 8448
