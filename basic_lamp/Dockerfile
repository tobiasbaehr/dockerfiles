FROM tobiasb/rb-basic-web

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-common\
    mysql-server\
    mysql-client\
    php5-mysql\
    php5-mcrypt
RUN service mysql start;sleep 2;mysqladmin -uroot password root;service mysql stop
ADD conf/mysql/supervisor-mysql.conf /etc/supervisor/conf.d/supervisor-mysql.conf

# PhpMyadmin
RUN mkdir -p /root/phpmyadmin
ADD conf/phpmyadmin/config.inc.php /root/phpmyadmin/config.inc.php
ADD scripts/build_phpmyadmin.sh /root/phpmyadmin/build_phpmyadmin.sh
RUN sh /root/phpmyadmin/build_phpmyadmin.sh 4.1.14
ADD conf/phpmyadmin/phpmyadmin.conf /etc/apache2/conf.d/phpmyadmin.conf
