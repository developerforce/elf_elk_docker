#!/bin/bash

Name=$1
Image=$2
MachineName=$3
Prefix=""

if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(docker-machine env $MachineName)"
else
	# Set up shell as root if using linux.
	Prefix="sudo"
fi

# Remove container and image.
$Prefix docker rm $Name
$Prefix docker rmi $Image