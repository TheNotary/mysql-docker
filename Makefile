DOCKER_IMAGE_NAME=mysql-docker
DATA_DIRECTORY=/data/mysql-docker-db

build:
	docker build -t ${USER}/${DOCKER_IMAGE_NAME} .

run:
	(docker start ${DOCKER_IMAGE_NAME}) || \
	docker run \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=blah \
  -v ${DATA_DIRECTORY}:/var/lib/mysql \
  -p 3306:3306 \
  --name ${DOCKER_IMAGE_NAME} -d ${USER}/${DOCKER_IMAGE_NAME}

console:
	docker run -it \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=blah \
  -v ${DATA_DIRECTORY}:/var/lib/mysql \
  -p 3306:3306 \
  ${USER}/${DOCKER_IMAGE_NAME} bash

.PHONY: build
