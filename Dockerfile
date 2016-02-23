FROM php:5.6-apache

# Enable apache rewrite module
RUN a2enmod rewrite

# Install drupal/drush/php dependencies
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        mysql-client \
    && docker-php-ext-install -j$(nproc) iconv \
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
        pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install drush and drush_typeinfo
ADD http://files.drush.org/drush.phar /usr/local/bin/drush
RUN chmod +x /usr/local/bin/drush && drush init -y

ADD https://ftp.drupal.org/files/projects/drupal-7.42.tar.gz /opt/drupal.tar.gz

RUN mkdir -p /opt/drupal \
    && tar -xvzf /opt/drupal.tar.gz -C /opt/drupal --strip-components=1 \
    && rm -rf /var/www/html \
    && mv /opt/drupal /var/www/html \
    && chown -R root:www-data /var/www/html
