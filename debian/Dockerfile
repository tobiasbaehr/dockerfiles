FROM debian:wheezy

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install -yqq \
    libreadline-gplv2-dev \
    libfreetype6 \
    apt-utils \
    dialog \
    debconf-utils

# Setup locale
RUN echo "locales locales/locales_to_be_generated multiselect de_DE.UTF-8 UTF-8"|debconf-set-selections \
&& echo "locales locales/default_environment_locale  select  de_DE.UTF-8"|debconf-set-selections \
&& DEBIAN_FRONTEND=noninteractive apt-get install locales -yqq &&\
    dpkg-reconfigure -f noninteractive locales
ENV LC_ALL de_DE.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    unzip \
    wget \
    curl \
    && echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc

# Define default command.
CMD ["bin/bash"]
