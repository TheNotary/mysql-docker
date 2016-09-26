# MySQL Docker Container

Here's the Dockerfile I use for spinning up MySQL containers.  It's pulled from the official `https://hub.docker.com/r/mysql/mysql-server/~/dockerfile/` with an added Makefile to ease creation.  If you'd prefer to copy from the originator, make sure you use `wget` to ensure the significant tab characters aren't replaced with spaces or things will go wrong.  

## Building the image

The below make command will build the image, naming it after your user account (review the Makefile for details).  

```
$ make
```

## Spinning up a new Container
To spin up a new container for use with any old project, execute something like this...

```
# Spin up the MySQL service container, something like...
$ docker run -it -e MYSQL_ROOT_PASSWORD=my-secret-pw --name=mysql_db_for_any_old_project ${USER}/mysql-docker /bin/bash

# Spin up the poject that will consume a MySQL service, something like...
$ docker run -itd --name=any_old_project --link mysql_db_for_any_old_project ${USER}/any-old-project
```

That might not totally work, you may get an error when trying to start `mysqld`.  You'll likely see the error in `/var/log/mysqld.log`.  Because alternative methods work (see below) I'll prosue this no further.  Feel free to create an issue or start your own repo for booting MySQL locally.  


## Want a Cleaner Workflow?

Building containers locally offers two benefits: 1) You have the ability to make modifications to the container if desired, 2) You gain a certainty that nothing malicious has been entered into the Dockerfile project.  Because MySQL is professionally maintained and included in DockerHub's official repositories, benefit 2 is a non-issue.  Because the MySQL hub will automate the creation of a Database if a DATABASE_NAME env var is supplied, a web developer will likely see little need in making modifications to the container.  If those conditions apply to you, then I recommend using the command for pulling MySQL and spinning up the server from DockerHUB rather than using this repo:

```
docker run --name piwik-db-container \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=piwik-db \
  -d mysql/mysql-server:8.0
```

Because this terminal command is infrastructure, it should be stored somewhere in version control.  My approach is to use Makefiles to automate the building and running of containers (see https://github.com/TheNotary/docker_repo/blob/master/Makefile.tt).  

This can be achieved by using a stanza such as:

```
boot-container-dependency:
  (docker start ${MYSQL_CONTAINER_NAME}) || \
  docker run --name piwik-db-container \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=piwik-db \
  -d mysql/mysql-server:8.0
```

You might need a way to stop and possibly remove the container, `docker stop/rm piwik-db-container` will do this.  There's also a switch for having the container boot at system boot.  

