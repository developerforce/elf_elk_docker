#!/bin/sh

MachineName=$1

# Set up virtualbox on mac if it doesnt exit.
MachineExist=$(docker-machine ls | grep -coE $MachineName)
if [[ $MachineExist == 1 ]]; then
	echo "A docker virtualbox exist."
else 
	docker-machine create --virtualbox-memory 4096 --driver virtualbox "$MachineName" 
fi