FROM java:8
MAINTAINER mislam@salesforce.com

# Update
RUN apt-get update 

# Vim
RUN apt-get -y install vim

# Download Elasticsearch, Kibana, Logstash, SFDC_ELF plugin, and config file
RUN mkdir elk \
	&& cd elk \
	&& wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz \
	&& wget https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz \
	&& wget https://download.elastic.co/logstash/logstash/logstash-1.5.5.tar.gz

# Go into elk folder, untar and remove tar files.
RUN cd elk \
	&& for file in *.tar.gz; do tar -zxf $file; done \
	&& rm *.tar.gz \
	&& rm -rf __MACOSX 

# Scripts and config
ADD ./sfdc_elf.config /elk/
ADD scripts/start.sh /elk/
RUN chmod +x /elk/start.sh

# Install SFDC_ELF plugin
RUN /elk/logstash-1.5.5/bin/plugin install logstash-input-sfdc_elf

# Add Elasticsearch cluster name.clear
RUN echo "cluster.name: elasticsearch" >> /elk/elasticsearch-1.7.1/elasticsearch.yml

CMD [ "/elk/start.sh" ]
