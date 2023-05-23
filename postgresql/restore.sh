source ../.env

# cat pg_dump.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}

cat dump_23-05-2023_19_39_43.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}