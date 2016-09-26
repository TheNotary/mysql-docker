# MySQL Docker Container

NOTE:  This repo does not currently work and may be abandoned in favor of simply using docker hub images.  

Here's the Dockerfile I use for spinning up MySQL containers.  It's pulled from the official `https://hub.docker.com/r/mysql/mysql-server/~/dockerfile/` with an added Makefile to ease creation.  

## Building the image

The below make command will build the image, naming it after your user account (review the Makefile for details).  

```
$ make
```

## Spinning up a new Container
To spin up a new container for use with any old project, execute something like this...

```
# Spin up the MySQL service container, something like...
$ docker run -itd --name=mysql_db_for_any_old_project ${USER}/mysql-docker /bin/bash

# Spin up the poject that will consume a MySQL service, something like...
$ docker run -itd --name=any_old_project --link mysql_db_for_any_old_project ${USER}/any-old-project
```

