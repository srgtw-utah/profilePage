# @see http://docs.docker.jp/compose/reference/index.html

include .env

APP_CONT_IP := $(shell (docker-machine ip || echo $${DOCKER_HOST} | awk '$$0; !$$0 {print "localhost"}' | sed -e 's%.*://%%' -e 's%:.*%%') 2>/dev/null)
APP_URL := http://$(APP_CONT_IP):$(APP_CONT_PORT)

# for bash on windows
DOCKER := $(shell printf "%sdocker" "$$(which winpty 2>/dev/null) ")

up:
	docker-compose up -d
	@sleep 1 # wait for server process is running.

all: clean build up test

build:
	docker-compose build --force-rm --no-cache

bash:
	$(DOCKER) exec -it $(APP_CONT_NAME) bash

destroy: clean
	-docker kill $$(docker ps -aq)
	-docker rm -f $$(docker ps -aq)
	-docker images -a | awk '/<none>/ {print $$3}' | xargs docker rmi -f

down:
	docker-compose down

clean:
	docker-compose down --rmi all

test:
	@printf "%s..." "GET $(APP_URL)/"
	@(($$(curl $(APP_URL)/ -o /dev/null -sw '%{response_code}') == 200)) && echo OK || echo NG
