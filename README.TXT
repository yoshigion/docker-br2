Step.0) Prepare docker volumes (Do ONLY ONCE at a system)

$ docker volume create --name=br2-ccache
$ docker volume create --name=br2-dl


Step.1) Prepare outputs' directory

$ chmod a+w br2-output


Step 2) Build docker-compose

$ docker-compose build


Step.3-a) Build manually in docker container

$ docker-compose up -d
$ docker-compose exec br2 bash
(login docker container)
% ./setup.sh
% ./build.sh
% exit
(output is "br2-output/sdcard.img")


Step.3-b) Build automatically

(uncomment #entrypoint -> entrypoint of docker-compose.yml)
$ docker-compose build
$ docker-compose run br2
(output is "br2-output/sdcard.img")
