FROM debian:9.3-slim

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    duply \
    python-boto \
    python-paramiko \
    rsync \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY entrypoint.sh /entrypoint.sh

CMD ["backup"]
