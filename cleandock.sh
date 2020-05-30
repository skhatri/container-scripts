#!/bin/bash

container_count=0
for x in $(docker ps -a --format '{{.ID}}:{{.Status}}'|grep -e "Exited\|Created"|awk -F":" '{print $1}'); 
do 
  docker rm $x; 
  container_count=$((container_count + 1))
done;

dangling_count=0
for x in $(docker images -f dangling=true -q);
do
  docker rmi -f $x
  dangling_count=$((dangling_count + 1))
done;

if [[ $dangling_count -gt 0 ]];
then
  echo removed ${dangling_count} dangling docker images.
fi;

if [[ $container_count -gt 0 ]];
then
  echo removed ${container_count} exited containers.
fi;

if [[ $dangling_count -eq 0 ]] && [[ $container_count -eq 0 ]];
then
  echo up-to-date. Nothing to clean.
fi;

if [[ -d "$HOME/Library/Containers/com.docker.docker/Data" ]];
then
  size=$(echo $(du -sh $HOME/Library/Containers/com.docker.docker/Data)|awk -F" " '{print $1}')
  echo "Docker Storage: ${size}"
fi;
