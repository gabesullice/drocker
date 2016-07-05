DROCKER_UPSTREAM=git@github.com:gabesullice/drocker.git
VENDOR_DIRECTORY=./vendor
DROCKER_DIRECTORY=$(VENDOR_DIRECTORY)/drocker

init: docker-compose.yml Dockerfile Dockerfile.development .data/drupal/private/hash_salt.txt .dockerignore .data

deinit:
	- rm -rf $(DROCKER_DIRECTORY)
	- rm ./drocker
	- rm ./docker-compose.yml
	- rm ./Dockerfile
	- rm ./Dockerfile.development
	- rm ./.dockerignore

Dockerfile:
	cp $(DROCKER_DIRECTORY)/bootstrap/Dockerfile.d$(DRUPAL_VERSION).example ./Dockerfile

Dockerfile.development:
	cp $(DROCKER_DIRECTORY)/bootstrap/Dockerfile.d$(DRUPAL_VERSION).development.example ./Dockerfile.development

.data/drupal/private/hash_salt.txt: .data
	mkdir -p $(shell dirname $@)
	head -c 100 /dev/urandom | base64 -w0 > $@

.data:
	cp -r $(DROCKER_DIRECTORY)/bootstrap/.data.d$(DRUPAL_VERSION).example ./.data

.dockerignore:
	cp $(DROCKER_DIRECTORY)/bootstrap/.dockerignore.example ./.dockerignore

docker-compose.yml: drocker
	cp $(DROCKER_DIRECTORY)/bootstrap/docker-compose.yml.d$(DRUPAL_VERSION).example ./docker-compose.yml

drocker: vendor
	git clone --depth 1 --recursive $(DROCKER_UPSTREAM) $(DROCKER_DIRECTORY)

vendor:
	mkdir -p $(VENDOR_DIRECTORY)

.PHONY: deinit drocker
