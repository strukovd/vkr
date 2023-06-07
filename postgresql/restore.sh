source ../.env

echo "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME} -d ${PG_DATABASE_NAME}
cat dump_01-06-2023_19_20_30.sql | docker exec -i ${PG_CONTAINER_NAME} psql -U ${PG_USERNAME} -d ${PG_DATABASE_NAME}
