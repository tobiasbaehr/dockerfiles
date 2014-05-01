FROM tobiasb/rb-basic-lamp

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Setup https://github.com/drush-ops/drush
RUN sudo -u dev mkdir -p /home/dev/.composer && sudo -u dev composer global require drush/drush:dev-master -d /home/dev/.composer
RUN sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' /home/dev/.bashrc
