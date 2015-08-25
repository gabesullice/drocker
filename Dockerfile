FROM php:5.6-apache

#RUN apt-get update && \
#    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
#    docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql

RUN a2enmod rewrite

COPY config/php.ini /usr/local/etc/php/
COPY config/*.conf /etc/apache2/sites-available/
COPY config/*.conf /etc/drocker/config/

RUN mkdir -p /var/www/site/data/files \
      /var/www/site/data/private/tmp && \
    chown -R www-data:www-data /var/www/site/data

RUN for site in /etc/drocker/config/*.conf; do \
      a2ensite $(basename $site); \
    done
