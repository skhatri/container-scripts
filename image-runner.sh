
start() {
  docker run --name ${container_name} ${volume_mapping} ${env_mapping} ${port_mapping} -dt ${image_tag}
}

found=0
for x in $(docker ps -a --format '{{.ID}}:{{.Names}}:{{.Status}}'|sed s/" "/"-"/g);
do
  read id name status <<< $(echo $x|awk -F":" '{print $1" "$2" "$3}');
  if [[ $status =~ Exited.* ]];
  then
    echo removing old container ${id} for ${name}
    docker rm -f ${id}
  else
    if [[ $name == "${container_name}" ]];
    then
      echo ${container_name} is already running! container: ${id}, status: ${status}
      found=1
    fi;
  fi;
done;

if [[ $found -eq 0 ]];
then
  start
fi;

count=0
while [[ true ]];
do
  x=$(docker ps -a --format '{{.ID}}:{{.Names}}:{{.Status}}'|sed s/" "/"-"/g);
  read id name status <<< $(echo $x|awk -F":" '{print $1" "$2" "$3}');
  if [[ $status =~ Up.* ]];
  then
    break;
  else
    sleep 1;
    count=$((count+1))
  fi;
  if [[ $count -gt 10 ]];
  then
    echo could not verify ${container_name} to be up. giving up.
    exit 1;
  fi;
done;
