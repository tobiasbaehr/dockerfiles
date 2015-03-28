FROM debian:wheezy

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
    libreadline-gplv2-dev\
    libfreetype6\
    apt-utils\
    dialog\
    debconf-utils\
    tzdata\
    unzip\
    wget\
    curl &&\
    rm -rf /var/lib/apt/lists/* &&\
    echo "Europe/Berlin" > /etc/timezone &&\
    dpkg-reconfigure -f noninteractive tzdata &&\
    echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc
