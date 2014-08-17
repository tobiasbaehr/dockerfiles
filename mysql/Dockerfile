FROM reinblau/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server netcat
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD scripts/start.sh /opt/start.sh

# Expose ports.
EXPOSE 3306

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

# Define default command.
CMD ["bin/bash", "/opt/start.sh"]
