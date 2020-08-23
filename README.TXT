* Prepare docker volumes and directories

$ chmod a+w br2/build
$ docker volume create --name=buildroot-dl
$ docker volume create --name=buildroot-dl

* Build and Exec docker-compose

$ docker-compose build
$ docker-compose up -d
$ docker-compose exec br2 bash

* Build manually in docker container

% ./setup.sh
% ./build.sh
% exit

//NOT VERIFY YET
//* Build automatically
//
//(uncomment #entrypoint of docker-compose.yml)
//$ docker-compose build
//$ docker-compose up -d
