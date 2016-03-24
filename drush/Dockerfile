FROM gabesullice/drocker-drupal-7

RUN apk add --no-cache \
      mysql-client

RUN wget http://files.drush.org/drush.phar \
      && php drush.phar core-status \
      && chmod +x drush.phar \
      && mv drush.phar /usr/local/bin/drush \
      && drush init -y

WORKDIR /var/www/html
