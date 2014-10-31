FROM reinblau/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

ENV SOLR_VERSION 3.6.1

ENV SEARCH_API_SOLR_VERSION 7.x-1.6

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install -y \
  openjdk-7-jre-headless \
  tar

RUN mkdir -p /opt
ADD http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz /opt/apache-solr-$SOLR_VERSION.tgz
RUN tar -C /opt --extract --file /opt/apache-solr-$SOLR_VERSION.tgz && \
    mv /opt/apache-solr-$SOLR_VERSION /opt/solr

WORKDIR /tmp

RUN wget http://ftp.drupal.org/files/projects/search_api_solr-$SEARCH_API_SOLR_VERSION.zip && \
unzip search_api_solr-$SEARCH_API_SOLR_VERSION.zip && \
rm search_api_solr-$SEARCH_API_SOLR_VERSION.zip

RUN cp -R search_api_solr/solr-conf/3.x/* /opt/solr/example/solr/conf/

EXPOSE 8983

CMD /bin/bash -c "cd /opt/solr/example; java -Xmx256m -jar start.jar"
