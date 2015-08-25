PHP_CONTAINER_NAME=drupal
SQL_CONTAINER_NAME=mysql
PHP_IMAGE_NAME=apache-php
SQL_IMAGE_NAME=mysql:5.6
VOLUMES=-v "$(shell pwd)/site/data/log:/var/www/site/log" \
				-v "$(shell pwd)/site/docroot:/var/www/site/docroot"

SQL_ROOT_PASS=-e MYSQL_ROOT_PASSWORD=mysupersecretpass
SQL_CREDENTIALS=-e MYSQL_DATABASE=drupal \
								-e MYSQL_USER=drupal \
								-e MYSQL_PASSWORD=myotherpass 

run: php mysql
	- docker kill $(PHP_CONTAINER_NAME)
	- docker rm $(PHP_CONTAINER_NAME)
	docker run -d --name $(PHP_CONTAINER_NAME) \
		$(VOLUMES) \
		-p 80:80 \
		--link $(SQL_CONTAINER_NAME):sql \
		$(PHP_IMAGE_NAME)

php:
	docker build -t $(PHP_IMAGE_NAME) .

mysql:
	docker pull $(SQL_IMAGE_NAME)
	- docker kill $(SQL_CONTAINER_NAME)
	- docker rm $(SQL_CONTAINER_NAME)
	docker run -d \
		--name $(SQL_CONTAINER_NAME) \
		$(SQL_ROOT_PASS) \
		$(SQL_CREDENTIALS) \
		$(SQL_IMAGE_NAME)
