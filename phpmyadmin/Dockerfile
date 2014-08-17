FROM reinblau/lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# PhpMyadmin
RUN mkdir -p /root/phpmyadmin
ADD conf/phpmyadmin/config.inc.php /root/phpmyadmin/config.inc.php
ADD scripts/build_phpmyadmin.sh /root/phpmyadmin/build_phpmyadmin.sh
RUN sh /root/phpmyadmin/build_phpmyadmin.sh

ADD conf/apache/000-default /etc/apache2/sites-enabled/000-default

ADD scripts/start.sh /opt/start.sh

RUN chmod +x /opt/start.sh

# Define default command.
CMD ["bin/bash", "/opt/start.sh"]
