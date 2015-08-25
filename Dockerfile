FROM php:5.6-apache

RUN apt-get update && apt-get install -y git libpng12-dev libjpeg-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql pcntl zip

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

ADD https://github.com/drush-ops/drush/archive/7.0.0.tar.gz /root/drush-7.0.0.tar.gz

RUN cd /root && \
    tar -xzf /root/drush-7.0.0.tar.gz && \
    chmod u+x /root/drush-7.0.0/drush && \
    ln -s /root/drush-7.0.0/drush /usr/bin/drush &&\
    cd /root/drush-7.0.0 && \
    composer install

COPY config/php.ini /usr/local/etc/php/
COPY config/*.conf /etc/apache2/sites-available/
COPY config/*.conf /etc/drocker/config/

RUN mkdir -p /var/www/site/data/files \
      /var/www/site/data/private/tmp && \
    chown -R www-data:www-data /var/www/site/data

RUN for site in /etc/drocker/config/*.conf; do \
      a2ensite $(basename $site); \
    done

WORKDIR /var/www/site/docroot
