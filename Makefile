DOCKER_IMAGE_NAME = mysql-docker

build:
	docker build -t ${USER}/${DOCKER_IMAGE_NAME} .

# If you have to configure volumes, do that from here
# configure:

run:
	(docker start ${DOCKER_IMAGE_NAME}) || \
	docker run --name ${DOCKER_IMAGE_NAME} -d ${USER}/${DOCKER_IMAGE_NAME}

console:
	docker run -it \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  ${USER}/${DOCKER_IMAGE_NAME} bash

.PHONY: build
