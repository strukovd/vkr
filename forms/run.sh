docker stop forms && docker rm forms;

docker build -t forms .;

docker run --restart=always -d \
        -p 8080:8080 \
        -v $(pwd)/storage/:/storage \
        -e TZ=Asia/Bishkek \
        --name=forms \
        forms:latest;

# docker images | grep '<none>' | awk '{print $3; }' | xargs docker rmi;

docker logs -f forms;