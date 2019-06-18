# @see http://docs.docker.jp/compose/reference/index.html

include .env

APP_CONT_IP := $(shell (docker-machine ip || echo $${DOCKER_HOST} | awk '$$0; !$$0 {print "localhost"}' | sed -e 's%.*://%%' -e 's%:.*%%') 2>/dev/null)
APP_URL := http://$(APP_CONT_IP):$(APP_CONT_PORT)

# for bash on windows
DOCKER := $(shell printf "%sdocker" "$$(which winpty 2>/dev/null) ")

up:
	docker-compose up -d
	@sleep 1 # wait for server process is running.

all: image up test

image: node
	docker-compose build --force-rm --no-cache

# fixme sharering directory, fail npm i on container.
node: node_modules
node_modules: package.json package-lock.json
	npm i

bash:
	$(DOCKER) exec -it $(APP_CONT_NAME) bash

destroy: clean
	rm -rf node_nodules
	-docker kill $$(docker ps -aq)
	-docker rm -f $$(docker ps -aq)
	-docker images -a | awk '/<none>/ {print $$3}' | xargs docker rmi -f

down:
	docker-compose down

clean:
	docker-compose down --rmi all

test:
	curl -s $(APP_URL)/
	curl -s $(APP_URL)/osawa/
	curl -s $(APP_URL)/takeya/
