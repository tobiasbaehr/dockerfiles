FROM reinblau/lamp:5.6

# PhpMyadmin

ADD https://github.com/phpmyadmin/phpmyadmin/archive/STABLE.zip /tmp/phpmyadmin.zip

WORKDIR /tmp

RUN unzip -q phpmyadmin.zip && rm phpmyadmin.zip && mv `ls` phpmyadmin && ls -lah phpmyadmin/

ADD conf/phpmyadmin/config.inc.php /tmp/phpmyadmin/config.inc.php

RUN chmod 644 phpmyadmin/config.inc.php && rm -rf /var/www/html && mv phpmyadmin /var/www/html

ENV MYSQL_ROOT_PASSWORD root
