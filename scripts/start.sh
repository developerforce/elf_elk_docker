#!/bin/bash

# Go into elk directory
cd elk

# Run 2 nodes of Elasticsearch stack.
./elasticsearch-1.7.1/bin/elasticsearch & 
(sleep 5; ./elasticsearch-1.7.1/bin/elasticsearch) & 

# Run Kibana & Logstash
(sleep 5; ./kibana-4.1.1-linux-x64/bin/kibana) &
(sleep 5; ./logstash-1.5.4/bin/logstash --verbose -f sfdc_elf.config)