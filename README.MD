
Build the project:

clj -T:build clean
clj -T:build main

docker build -t hello-app .
docker run hello-app
