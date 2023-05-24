#!/bin/bash

source ./.env

docker stop ${PG_CONTAINER_NAME} && docker rm ${PG_CONTAINER_NAME}
