#!/bin/bash

Name=$1
MachineName=$2
Prefix=""


if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(docker-machine env $MachineName)"
else
	# Set up shell as root if using linux.
	Prefix="sudo"
fi

# Resume docker container only if it exist.
DockerName=$($Prefix docker ps -a | grep -coE $Name)
if [[ $DockerName == 1 ]]; then
	$Prefix docker start $Name
	$Prefix docker attach $Name
else 
	echo "elf_on_elk_container does not exist. Use 'make run' to create one and run it."
fi