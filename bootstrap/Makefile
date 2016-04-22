DROCKER_UPSTREAM=git@github.com:gabesullice/drocker.git

init: docker-compose.yml drocker Dockerfile .dockerignore

deinit:
	- rm -rf ./vendor
	- rm ./drocker
	- rm ./docker-compose.yml
	- rm ./Dockerfile
	- rm ./.dockerignore

Dockerfile:
	cp ./vendor/drocker/bootstrap/Dockerfile.d$(DRUPAL_VERSION).example ./Dockerfile

.dockerignore:
	cp ./vendor/drocker/bootstrap/.dockerignore.example ./.dockerignore

docker-compose.yml: upstream
	cp ./vendor/drocker/bootstrap/docker-compose.yml.d$(DRUPAL_VERSION).example ./docker-compose.yml

drocker: upstream
	ln -sf ./vendor/drocker/command/drocker ./drocker

upstream: vendor
	git clone --depth 1 --recursive $(DROCKER_UPSTREAM) ./vendor/drocker

vendor:
	mkdir -p ./vendor

.PHONY: deinit upstream
