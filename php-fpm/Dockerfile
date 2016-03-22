FROM php:5.6-fpm-alpine

# Install php dependencies for Drupal
RUN apk add --no-cache \
      freetype-dev \
      libjpeg-turbo-dev \
      libmcrypt-dev \
      libpng-dev \
      libxml2-dev 

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} \
      iconv \
      mcrypt \
      mbstring \
      opcache \
      hash \
      json \
      pdo \
      session \
      tokenizer \
      xml \
      dom \
      simplexml \
      pdo_mysql

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} gd

ADD https://ftp.drupal.org/files/projects/drupal-7.43.tar.gz /opt/drupal.tar.gz

RUN mkdir -p /opt/drupal \
    && tar -xvz -C /opt/drupal -f /opt/drupal.tar.gz \
    && rm -rf /var/www/html \
    && mv /opt/drupal/drupal-* /var/www/html \
    && chown -R root:www-data /var/www/html
