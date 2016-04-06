FROM gabesullice/drocker-php-fpm

RUN apk add --no-cache \
      mysql-client

# Install composer
ADD https://getcomposer.org/installer /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --filename=composer --install-dir=/usr/local/bin \
    && rm /tmp/composer-setup.php

# Install drush
RUN wget http://files.drush.org/drush.phar \
      && php drush.phar core-status \
      && chmod +x drush.phar \
      && mv drush.phar /usr/local/bin/drush \
      && drush init -y

# Install drupal console
ADD https://drupalconsole.com/installer /tmp/drupal.phar
RUN php /tmp/drupal.phar \
    && mv /tmp/drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init --override \
    && sed -i /mysql/d /root/.console/phpcheck.yml

WORKDIR /var/www/html
