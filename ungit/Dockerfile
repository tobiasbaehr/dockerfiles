FROM reinblau/cmd

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN npm install ungit -g

EXPOSE 8448

CMD ["/usr/bin/ungit", "--no-launchBrowser", "--forcedLaunchPath=/var/www"]
