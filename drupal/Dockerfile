FROM reinblau/lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

ENV COMPOSER_HOME /opt

# Setup https://github.com/drush-ops/drush
RUN composer global require drush/drush:6.3.0

RUN ln -s /opt/vendor/bin/drush /usr/bin/drush

# https://drupal.org/project/registry_rebuild
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands && drush dl registry_rebuild

# https://github.com/reinblau/yadd
RUN git clone https://github.com/reinblau/yadd.git /opt/yadd
