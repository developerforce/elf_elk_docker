# Salesforce Event Log File on ELK Stack on Docker

## Overview
Salesforce Event Log File (ELF) exposes organizational usage trends and user behavior via the [EventLogFile sObject](https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_eventlogfile.htm). It's a fantastic feed of data that enables customers to derive insights from analytic platforms like ELK.

The [ELK stack](https://www.elastic.co/products) is an open-source, scalable log management stack that supports exploration, analysis, and visualization of log data. 

It consists of:

1. Elasticsearch: A Lucene-based search server for storing log data.
2. Logstash: ETL process for retrieving, transforming, and pushing logs into data warehouses.
3. Kibana: Web GUI for exploring, analyzing, and visualizing log data in Elasticsearch.

Because ELK is on-premise, we are using [Docker](https://www.docker.com/whatisdocker) as a container of settings to simplify the deployment and running of the ELK stack on commoditized hardware.

The Salesforce Event Log File [Ruby Gem](https://rubygems.org/gems/logstash-input-sfdc_elf/) plug-in simplifies the integration between the ELK stack and Event Log Files by allowing you to easily download and index Salesforce event data every day without a custom integration.

To get started, all you have to do is download this repo, modify a config file, and start the service. 

## Prerequisites
* Supported Operating Systems   
 Linux and Mac OS X.  
 Windows is not tested and not supported at the moment. However, it reportedly works when running Docker without Makefile.
  
* Docker  
 Install the latest version of Docker from [here](https://docs.docker.com/installation/).
 You may need to restart the service after installing before you can test it with the hello-world container (e.g. sudo service docker start).
 
* System Requirements  
  Varies by the amount of event log file data your Salesforce organization generates. It is recommended that you have at least 4GB RAM and 16GB of free hard disk space at the minimum.

## Event Log File Logstash Plugin Configuration
This section guides you in setting up Logstash Event Log File plugin configuration. The configuration is defined in the `sfdc_elf.config` file. Complete the following parameters in your config file:

1. username: Your Salesforce username.
2. password: Your Salesforce password.
3. client_id: Salesforce connected App client ID. See 'Setting up Salesforce Connected App' section below. 
4. client_secret: Salesforce connected App client secret. See 'Setting up Salesforce Connected App' section below. 
5. security_token: Your account's security token only needed when your Force.com organization requires it.

## Instructions
### Running ELF on ELK on Docker
1. Ensure you already have Docker installed. Additionally, you need Docker Machine (not boot2docker) if you are using Max OS X.
2. Clone or download this GIT repository.
3. Complete the Logstash configuration (`sfdc_elf.config` file). See previous section for details.
4. We provide Makefile to help you easily manage Docker images. Run your Docker container using `make run`. You will need to use your terminal to first navigate to the directory where this GIT repo was downloaded to (i.e. cd ~/Documents/elf_elk_docker-master) before running `make run`.
   Additional information about managing Docker containers:  
   `make remove` removes an already running Docker container.  
   `make resume` resumes an existing but stopped Docker container.   
   If you are an advanced Docker user or use Windows platform, you might want to look inside `scripts/` directory on how to run (`scripts/run.sh`), resume (`scripts/resume.sh`), or remove (`scripts/remove.sh`) Docker images.

### Exploring, Analyzing, and Visualizing Data in Kibana
1. Kibana is configured to run on port 8081. You can access it from your web browser using `localhost:8081` in Linux. For Max OS X, run `docker-machine ip default` to determine your virtual machine's IP. Then access Kibana by going to that IP at port 8081 (e.g. http://192.168.98.100:8081).
2. Set index pattern in *Settings > Indices* to `logstash-*` and click *Create*. Some mapping conflicts may occur which is fine. See screenshot below.
3. Click *Discover* and start exploring and visualizing your data. 

![alt text](https://cloud.githubusercontent.com/assets/7350893/10236694/c8afddac-685d-11e5-813c-82bc0c7c8e0f.gif)

## Appendix
### Setting up a Salesforce Connected App
Detailed instructions for setting up a Connected App can be found [here](https://help.salesforce.com/apex/HTViewHelpDoc?id=connected_app_create.htm).
When configuring the connected application, ensure the following options are configured:

1. *Enable OAuth Settings* is checked.
2. *Access and manage data (api)* and *Access your basic information (id, profile, email, address, phone)* are included in your *Selected OAuth Scopes*.