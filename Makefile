PHP_CONTAINER_NAME=drupal
PHP_IMAGE_NAME=apache-php

SQL_CONTAINER_NAME=mysql
SQL_IMAGE_NAME=mysql:5.6

MAIL_CONTAINER_NAME=mail
MAIL_IMAGE_NAME=schickling/mailcatcher

PHP_VOLUMES=-v "$(shell pwd)/site/data:/var/www/site/data" \
						-v "/data/site/docroot:/var/www/site/docroot" \
						-v "/data/site/files:/data/site/files"

SQL_VOLUMES=-v "/data/sql:/var/lib/mysql"

SQL_ROOT_PASS=-e MYSQL_ROOT_PASSWORD=mysupersecretpass
SQL_CREDENTIALS=-e MYSQL_DATABASE=drupal \
								-e MYSQL_USER=drupal \
								-e MYSQL_PASSWORD=myotherpass 

run: php mysql mailcatcher
	- docker kill $(PHP_CONTAINER_NAME)
	- docker rm $(PHP_CONTAINER_NAME)
	docker run -d --name $(PHP_CONTAINER_NAME) \
		$(PHP_VOLUMES) \
		-p 80:80 \
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
		-p 1080:1080 \
		$(MAIL_IMAGE_NAME)
	
