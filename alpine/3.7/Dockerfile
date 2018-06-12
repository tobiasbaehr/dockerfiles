FROM alpine:3.7

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
  apk del tzdata

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && echo "1d2e0cdf0fe571b05336683972d593dc8e7602b30551c2316e5371b12c7e355e4046ceedb956c3aaa6e42277d0a9473d00150478f94f953b900fc920b69eed1f  dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz"  | sha512sum -c - \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
