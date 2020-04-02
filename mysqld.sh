#!/bin/bash

export container_name="mysql"
export volume_mapping="-v $HOME/dev/data/mysql/data:/var/lib/mysql"
export env_mapping="-e MYSQL_ROOT_PASSWORD=root"
export port_mapping="-p 3306:3306"
export image_tag="mysql:8.0.19"


cwd=$(dirname $0)
. ${cwd}/image-runner.sh
