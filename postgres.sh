#!/bin/bash

export container_name="postgres"
export volume_mapping="-v $HOME/dev/data/postgres/data:/var/lib/postgresql/data"
export env_mapping="-e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=admin"
export port_mapping="-p 5432:5432"
#has a todo task schema and table on top of postgres 11.5
export image_tag="skhatri/todo-postgres:11.5"

cwd=$(dirname $0)
. ${cwd}/image-runner.sh
