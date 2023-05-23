source ./.env

function run_postgresql() {
	if docker ps -a --format '{{.Names}}' | grep -q $PG_CONTAINER_NAME; then
		echo "Контейнер базы данных - [$PG_CONTAINER_NAME] уже запущен"
	else
		echo "Запуск: Postgresql"
		docker run -d \
			--name ${PG_CONTAINER_NAME} \
			--network=host \
			-e POSTGRES_USER=${PG_USERNAME} \
			-e POSTGRES_PASSWORD=${PG_PASSWORD} \
			-e POSTGRES_DB=${PG_DATABASE_NAME} \
			-e "TZ=Asia/Bishkek" \
			-v ./postgresql/backup/:/docker-entrypoint-initdb.d/ \
			-v ./postgresql/cache/${PG_CACHE_FOLDER}:/var/lib/postgresql/data \
			-v /etc/localtime:/etc/localtime \
			postgres
	fi
}




# Запуск контейнеров
run_postgresql
