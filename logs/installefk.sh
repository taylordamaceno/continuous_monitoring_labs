#!/bin/bash
sudo mkdir -p /docker/elastic/data;
sudo chmod -R g+rwx /docker/elastic;
sudo chown -R 1000:1000 /docker/elastic;
sudo sysctl -w vm.max_map_count=262144;
# Subindo Docker

docker run -d --name elastic \
 -p 9200:9200 -p 9300:9300 \
 --restart=always \
 -e "http.host=0.0.0.0" \
 -e "discovery.type=single-node" \
 -v /docker/elastic/data:/usr/share/elasticsearch/data \
 docker.elastic.co/elasticsearch/elasticsearch:$VERSAO

# Subindo kibana
docker run -d --name kibana \
 -p 5601:5601 \
 --restart=always \
 -e "ELASTICSEARCH_HOSTS=http://IP_SERVIDOR_ELASTIC:9200" \
 -e XPACK_GRAPH_ENABLED=true \
 -e XPACK_WATCHER_ENABLED=true \
 -e XPACK_ML_ENABLED=true \
 -e XPACK_MONITORING_ENABLED=true \
 -e XPACK_MONITORING_UI_CONTAINER_ELASTICSEARCH_ENABLED \
 docker.elastic.co/kibana/kibana:$VERSAO
#Subindo logstash
docker run -d --name logstash \
 --restart=always \
 -e   "XPACK.MONITORING.ELASTICSEARCH.HOSTS=http://IP_SERVIDOR_ELASTIC:9200" \
 docker.elastic.co/logstash/logstash:$VERSAO

