FROM tobiasb/rb-basic-lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Setup https://github.com/drush-ops/drush
RUN sudo -u dev mkdir -p /home/dev/.composer && sudo -u dev composer global require drush/drush:dev-master -d /home/dev/.composer
RUN sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' /home/dev/.bashrc

# https://drupal.org/project/registry_rebuild
RUN sudo -u dev mkdir /home/dev/.drush && cd /home/dev/.drush && sudo -u dev php /home/dev/.composer/vendor/bin/drush.php dl registry_rebuild

# https://github.com/reinblau/yadd
RUN cd /home/dev && sudo -u dev git clone https://github.com/reinblau/yadd.git
