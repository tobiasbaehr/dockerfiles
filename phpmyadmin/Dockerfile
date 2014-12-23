FROM reinblau/lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# PhpMyadmin

ADD http://sourceforge.net/projects/phpmyadmin/files/latest/download /tmp/phpmyadmin.zip

WORKDIR /tmp

RUN unzip -q phpmyadmin.zip && rm phpmyadmin.zip && mv `ls` phpmyadmin && ls -lah phpmyadmin/

ADD conf/phpmyadmin/config.inc.php /tmp/phpmyadmin/config.inc.php

RUN chmod 644 phpmyadmin/config.inc.php && rm -rf /var/www && mv phpmyadmin /var/www

ADD conf/apache/000-default /etc/apache2/sites-enabled/000-default

ENV MYSQL_ROOT_PASSWORD root
