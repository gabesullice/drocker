PREFIX=gabesullice/drocker

drocker-drupal-composer:
	cd drupal-composer;\
	docker build -t $(PREFIX)-drupal-composer .

drocker-nginx-composer:
	cd nginx;\
	docker build -t $(PREFIX)-nginx-composer .

drocker-testing-composer:
	cd drupal-testing;\
	docker build -t $(PREFIX)-testing-composer .

drocker-drupal-composer-cli:
	cd drupal-cli;\
	docker build -t $(PREFIX)-drupal-composer-cli .

all: drocker-drupal-composer drocker-drupal-composer-cli drocker-testing-composer drocker-nginx-composer
