#!/bin/bash

Name=$1
Image=$2
Port=$3
MachineName=$4
Prefix=""

# Set up based on operating system.
if [[ "$OSTYPE" == "darwin"* ]]; then
	# Set up Virtual Box & environment variables.
	scripts/macVB.sh $MachineName
	eval "$(docker-machine env $MachineName)"
else
	# Set up shell as root.
	Prefix="sudo"
fi

# Build docker image and container for mac if it doesnt exit. 
DockerName=$($Prefix docker ps -a | grep -coE $Name)
if [[ $DockerName == 1 ]]; then
	echo "A elf_on_elk_container already exist. Use 'make resume' to resume it"
else 
	$Prefix docker build -t $Image .
	$Prefix docker run -it --name $Name -p $Port $Image | tee termStdout.txt
fi