#!/bin/bash
PHPMYADMINVERSION=$1

DST_DIR=/usr/local/src

SRC_DIR=/tmp

if ! [ -d "$DST_DIR" ];then
  mkdir -p $DST_DIR
fi

cd $SRC_DIR

wget -q http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/${PHPMYADMINVERSION}/phpMyAdmin-${PHPMYADMINVERSION}-all-languages.zip/download -O phpmyadmin-${PHPMYADMINVERSION}.zip

if [ -f "phpmyadmin-${PHPMYADMINVERSION}.zip" ];then

unzip -q phpmyadmin-${PHPMYADMINVERSION}.zip
rm phpmyadmin-${PHPMYADMINVERSION}.zip

mv phpMyAdmin-${PHPMYADMINVERSION}-all-languages phpMyAdmin

cp /root/phpmyadmin/config.inc.php $SRC_DIR/phpMyAdmin/config.inc.php && chmod 644 $SRC_DIR/phpMyAdmin/config.inc.php
mv $SRC_DIR/phpMyAdmin $DST_DIR/phpMyAdmin

fi
