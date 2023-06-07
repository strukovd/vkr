docker stop forms-fetcher && docker rm forms-fetcher;

docker build -t forms-fetcher .;

docker run --restart=always -d \
	--network host \
	-v $(pwd)/storage/:/storage \
	-e TZ=Asia/Bishkek \
	--name=forms-fetcher \
	forms-fetcher:latest;

docker images | grep '<none>' | awk '{print $3; }' | xargs docker rmi;

docker logs -f forms-fetcher;


#	--network=host \