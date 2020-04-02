#!/bin/bash

export container_name="cassandra"
export volume_mapping="-v $HOME/dev/data/cassandra/data:/var/lib/cassandra/data"
export env_mapping=""
export port_mapping="-p 9042:9042"
#image that uses PasswordAuthenticator
export image_tag="skhatri/cassandra:3.11"

cwd=$(dirname $0)
. ${cwd}/image-runner.sh
