docker stop forms-fetcher
docker rm forms-fetcher

docker run --restart=always -d \
	--network host \
	-v $(pwd)/storage/:/storage \
	-e TZ=Asia/Bishkek \
	--name=forms-fetcher \
	forms-fetcher:latest;

docker logs -f --tail 1000 forms-fetcher