source ../.env

echo "DROP DATABASE IF EXISTS $PG_FORMS_DATABASE_NAME" | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME}
echo "CREATE DATABASE $PG_FORMS_DATABASE_NAME" | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME}
echo "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;" | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME} -d ${PG_FORMS_DATABASE_NAME}
# cat dump_01-06-2023_19_20_30.sql | docker exec -i ${PG_FORMS_CONTAINER_NAME} psql -U ${PG_FORMS_USERNAME} -d ${PG_FORMS_DATABASE_NAME}
