FROM reinblau/lamp:5.6

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# PhpMyadmin

ADD https://github.com/phpmyadmin/phpmyadmin/archive/STABLE.zip /tmp/phpmyadmin.zip

WORKDIR /tmp

RUN apt-get update && apt-get install -y unzip && docker-php-ext-install mysqli && rm -rf /var/lib/apt/lists/*

RUN unzip -q phpmyadmin.zip && rm phpmyadmin.zip && mv `ls` phpmyadmin && ls -lah phpmyadmin/

ADD conf/phpmyadmin/config.inc.php /tmp/phpmyadmin/config.inc.php

RUN chmod 644 phpmyadmin/config.inc.php && rm -rf /var/www/html && mv phpmyadmin /var/www/html

ENV MYSQL_ROOT_PASSWORD root
