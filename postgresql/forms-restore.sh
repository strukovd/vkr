source ../.env

# cat pg_dump.sql | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME}

echo "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME} -d ${PG_FORMS_DATABASE_NAME}
cat forms_dump_07-06-2023_19_37_36.sql | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME} -d ${PG_FORMS_DATABASE_NAME}
