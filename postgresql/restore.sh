source ../.env

# cat pg_dump.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}
echo $PG_CONTAINER_NAME

cat dump_24-05-2023_03_29_27.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}