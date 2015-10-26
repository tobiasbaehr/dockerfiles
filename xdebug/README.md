XDEBUG
============

Uses as base image [php:5.6](https://hub.docker.com/r/library/php/).

Installed tools
-------------------------
* [webgrind]https://github.com/jokkedk/webgrind


Notes
-------------------------
Docker is installed in VM?

* copy docker-php-pecl-xdebug.ini.dist to docker-php-pecl-xdebug.ini
* change the xdebug.remote_host in docker-php-pecl-xdebug.ini to your Desktop IP e.g. provided by DHCP from the router

Hosts
-------------------------
xdebug.dd/webgrind
xdebug.dd/myproject
