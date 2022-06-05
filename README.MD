
# Build and deploy the project:

build:

`clj -T:build clean`

`clj -T:build uber`

`docker build -t hello-app .`

`docker run hello-app`

push the docker container to ecr!

in the terraform folder use:

`terraform init`

`terraform apply`

`aws ecs run-task  --cluster tryimport --task-definition fromecr:2 --launch-type="FARGATE" --network-configuration '{ "awsvpcConfiguration": {"assignPublicIp":"ENABLED", "securityGroups": ["sg-e9bd4ab9"], "subnets": ["subnet-0b170efc0b8f6f53b"]}}'`
