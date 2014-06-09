#!/usr/bin/env bash
set -o errexit
#set -x

DST_DIR=/var

SRC_DIR=/tmp

cd $SRC_DIR

wget -q http://sourceforge.net/projects/phpmyadmin/files/latest/download -O phpmyadmin.zip

if [ -f "phpmyadmin.zip" ];then
    unzip -q phpmyadmin.zip
    rm phpmyadmin.zip
else
    echo "Could not download phpmyadmin from http://sourceforge.net/projects/phpmyadmin/files/latest/download"
    exit 1
fi

mv `ls` phpmyadmin

if [ -d "phpmyadmin" ];then
    cp /root/phpmyadmin/config.inc.php $SRC_DIR/phpmyadmin/config.inc.php && chmod 644 $SRC_DIR/phpmyadmin/config.inc.php
    rm -rf $DST_DIR/www
    mv $SRC_DIR/phpmyadmin $DST_DIR/www
else
    echo "Could not install phpmyadmin."
    exit 1
fi

exit 0
