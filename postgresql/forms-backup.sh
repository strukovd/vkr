#!/bin/bash

source ../.env

# docker exec -t ${PG_CONTAINER_NAME} pg_dumpall -c -U ${PG_USERNAME} > pg_dump.sql #dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

docker exec -t ${PG_CONTAINER_NAME} pg_dumpall -c -U ${PG_USERNAME} > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql