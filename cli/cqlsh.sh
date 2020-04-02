#!/bin/bash

target="";
for container_name in $(docker ps -a --format '{{.Names}}:{{.Status}}'|grep ":Up"|awk -F":" '{print $1}');
do 
  if [[ $container_name == "dse" ]];
  then
    target="dse"
  fi;
  if [[ $container_name == "cassandra" ]];
  then 
    target="cassandra"
  fi;
done;

if [[ $target == "" ]];
then
  echo No Running Cassandra/DSE containers found.
  exit 1;
fi;
docker exec -it ${target} cqlsh $@
