step 1) Prepare docker volumes and directories

$ chmod a+w br2/build
$ docker volume create --name=br2-ccache
$ docker volume create --name=br2-dl

step 2) Build docker-compose

$ docker-compose build

step 3-a) Build manually in docker container

$ docker-compose up -d
$ docker-compose exec br2 bash
(login docker container)
% ./setup.sh
% ./build.sh
% exit
(output is "br2/build/sdcard.img")

step 3-b) Build automatically

(uncomment #entrypoint -> entrypoint of docker-compose.yml)
$ docker-compose build
$ docker-compose run br2
(output is "br2/build/sdcard.img")
