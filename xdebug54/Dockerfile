FROM reinblau/lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
    php5-xdebug\
    graphviz\
    python &&\
    rm -rf /var/lib/apt/lists/*
