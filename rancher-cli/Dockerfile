FROM alpine:3.7

ENV RANCHER_CLI_VERSION v0.6.7

RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  curl \
  ; \
  cd /tmp && curl -sSL https://releases.rancher.com/cli/$RANCHER_CLI_VERSION/rancher-linux-amd64-$RANCHER_CLI_VERSION.tar.gz > rancher-linux-amd64.tar.gz \
  && echo "671a42cf4a68ab29fba297034254299b5b380ef810d501ebea84517d6cab43d635d53f9ca9b1f2f9811e12d37fce3d91bb26f021cb7009b7689a2d232d5398ae  rancher-linux-amd64.tar.gz" | sha512sum -c - \
  && tar -xzf rancher-linux-amd64.tar.gz \
  && mv rancher-$RANCHER_CLI_VERSION/rancher /usr/local/bin/rancher \
  && chmod +x /usr/local/bin/rancher \
  && rm -rf /tmp/* \
  && apk del .build-deps

RUN set -xe; \
  apk add --no-cache --virtual .persistent-deps \
  duply \
  ; \
