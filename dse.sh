#!/bin/bash

export container_name="dse"
export volume_mapping="-v $HOME/dev/data/dse/data:/var/lib/cassandra/data"
export env_mapping="-e DS_LICENSE=accept"
export port_mapping="-p 9042:9042"
export image_tag="datastax/dse-server:6.0.6.p"

cwd=$(dirname $0)
. ${cwd}/image-runner.sh
