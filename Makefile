DOCKER_CMD=docker
BUILD_CMD=$(DOCKER_CMD) build --no-cache
PUSH_CMD=$(DOCKER_CMD) push

DOCKER_NAMESPACE=gabesullice

default: drocker-drupal-8 drocker-drupal-7 drocker-drupal-cli drocker-php-fpm drocker-nginx

drocker-drupal-8: php-fpm
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-drupal-8 drupal-8/8.2
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-drupal-8:latest
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-drupal-8:8.2 drupal-8/8.2
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-drupal-8:8.2
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-drupal-8:8.3 drupal-8/8.3
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-drupal-8:8.3

drocker-drupal-7: php-fpm
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-drupal-7 drupal-7
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-drupal-7

drocker-drupal-cli: php-fpm
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-drupal-cli drupal-cli
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-drupal-cli

drocker-php-fpm:
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-php-fpm php-fpm
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-php-fpm

drocker-nginx:
	$(BUILD_CMD) -t $(DOCKER_NAMESPACE)/drocker-nginx nginx
	$(PUSH_CMD) $(DOCKER_NAMESPACE)/drocker-nginx

.PHONY: *
