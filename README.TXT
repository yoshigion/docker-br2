* Build procedure

Step.0) Prepare docker volumes (Do ONLY ONCE at a system)

$ docker volume create --name=br2-ccache
$ docker volume create --name=br2-dl


Step.1) Prepare outputs' directory

$ chmod a+w br2-output


Step 2) Build docker-compose

$ docker-compose build


Step.3-a) Build automatically

$ docker-compose build
$ docker-compose run br2
(output is "br2-output/sdcard.img")


Step.3-b) Build manually in docker container

(comment entrypoint -> #entrypoint of docker-compose.yml)
$ docker-compose up -d
$ docker-compose exec br2 bash
(login docker container)
% ./setup.sh
% ./build.sh
% exit
(output is "br2-output/sdcard.img")



* How to change defconfig file

** Place new defconfig file to br2/
** Change filename varialble "DEFCONFIG_BR2" of docker-compose.yml
