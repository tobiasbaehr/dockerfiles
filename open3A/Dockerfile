FROM gzevd/php:5.6-alpine-apache

RUN set -xe; \
   cd /tmp && curl -sSL https://www.open3a.de/multiCMSDownload.php?filedl=99 > open3a.zip \
   && echo "94c36a2e0dd277aac986f1535c12e9e8c97b639f70fba1058297677eb6e504c490cb052ca489d15a03567be455992621eb18b366506887285d3972003d178abf  open3a.zip" | sha512sum -c - \
   && unzip open3a.zip -d /var/www/localhost/htdocs \
   && chown apache: /var/www/localhost/htdocs/system/DBData/Installation.pfdb.php \
   && rm -rf /tmp/*
