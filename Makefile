include config/make.conf

PHP_CONTAINER_NAME=drupal
PHP_IMAGE_NAME=apache-php

SQL_CONTAINER_NAME=mysql
SQL_IMAGE_NAME=mysql:5.6

MAIL_CONTAINER_NAME=mail
MAIL_IMAGE_NAME=schickling/mailcatcher

PHP_VOLUMES=-v "/var/docker/$(PROJECT_NAME)/share:/var/www/site/share" \
						-v "/var/docker/$(PROJECT_NAME)/docroot:/var/www/site/docroot" \
						-v "/var/docker/$(PROJECT_NAME)/files:/var/www/site/files"

SQL_VOLUMES=-v "/var/docker/$(PROJECT_NAME)/sql:/var/lib/mysql"

SQL_ROOT_PASS=-e MYSQL_ROOT_PASSWORD=mysupersecretpass
SQL_CREDENTIALS=-e MYSQL_DATABASE=drupal \
								-e MYSQL_USER=drupal \
								-e MYSQL_PASSWORD=myotherpass 

start:
	docker start mysql
	docker start mail
	docker start drupal

stop:
	docker stop mysql
	docker stop mail
	docker stop drupal

run: php mysql mailcatcher
	- docker kill $(PHP_CONTAINER_NAME)
	- docker rm $(PHP_CONTAINER_NAME)
	docker run -d --name $(PHP_CONTAINER_NAME) \
		$(PHP_VOLUMES) \
		-p $(LOCAL_WEB_PORT):80 \
		--link $(SQL_CONTAINER_NAME):sql \
		--link $(MAIL_CONTAINER_NAME):mail \
		$(PHP_IMAGE_NAME)

php:
	docker build -t $(PHP_IMAGE_NAME) .

mysql:
	docker pull $(SQL_IMAGE_NAME)
	- docker kill $(SQL_CONTAINER_NAME)
	- docker rm $(SQL_CONTAINER_NAME)
	docker run -d \
		--name $(SQL_CONTAINER_NAME) \
		$(SQL_VOLUMES) \
		$(SQL_ROOT_PASS) \
		$(SQL_CREDENTIALS) \
		$(SQL_IMAGE_NAME)

mailcatcher:
	docker pull schickling/mailcatcher
	- docker kill $(MAIL_CONTAINER_NAME)
	- docker rm $(MAIL_CONTAINER_NAME)
	docker run -d \
		--name $(MAIL_CONTAINER_NAME) \
		-p $(LOCAL_MAIL_PORT):1080 \
		$(MAIL_IMAGE_NAME)
	
