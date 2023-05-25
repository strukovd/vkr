source ../.env

# cat pg_dump.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}
echo $PG_CONTAINER_NAME

cat dump_26-05-2023_01_22_52.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME}