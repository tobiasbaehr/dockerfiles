FROM reinblau/lamp:5.6

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
  graphviz\
  python;\
  pecl install xdebug; \
  rm -rf /var/lib/apt/lists/*
