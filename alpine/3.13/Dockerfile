FROM alpine:3.13
# Upgrade
RUN set -xe; \
  apk update \
  && apk upgrade \
  && rm -rf /var/cache/* \
  && mkdir -p /var/cache/apk

#Set timezone
RUN set -xe; \
  apk add --update --no-cache tzdata;\
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone; \
  apk del --no-cache tzdata

ENV TZ /etc/localtime

# Install default packages
RUN set -xe; \
  apk add --update --no-cache \
    tar \
    patch \
    coreutils \
    less \
    sed \
    bash

SHELL ["/bin/bash", "-o", "xtrace", "-o", "pipefail", "-o", "errexit", "-c"]
