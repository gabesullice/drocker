Drocker
----

Drocker is a collection of CLI tools and Docker images for developing and running containerized Drupal sites.

## Overview
Drocker has three main components, a suite of base images, like nginx, php-fpm, and drocker-cli. These are configured to work in tandem and provide all the necessary dependencies for running Drupal. It then ships with two Drupal version dependent images, D7 and D8. These actually download and extract Drupal's source files into the container. Finally, Drocker has a command line tool, `drocker`. The CLI tool makes it easy to control the lifecycle of your local development, from running drush commands to spinning your containers up and down.

## Running on Linux
All you need to run Drocker instances on Linux is have the docker-engine and docker compose installed.

## Running on Mac or Windows
Until Docker for Mac/Windows Native is publicly available, Drocker is also bundled with an incredibly minimalistic Vagrant setup. Unlike many other local development environments like Drupal VM, which suffer from slow local performance when running Drupal from a shared directory (NFS or Vagrant Sync), Drocker flips NFS sharing to share your code TO your local machine, rather that sharing your code INTO the VM. This greatly improves PHP's performance characteristics within the VM.

## Components
- drocker-nginx
  - Contains a simple instance of NGINX configured to proxy to Drupal running as PHP-FPM.
- drocker-php-fpm
  - This image contains an installation of PHP 5.6 FPM with all the necessary PHP libs from running Drupal.
- drocker-cli
  - This image provides the latests versions of composer, drupal console, and drush. When you run `drocker connect`, you are dropped into a shell session in the container, which will be connected to your Drupal container via shared volumes.
- drocker-drupal-8
  - This image builds off drocker-php-fpm image. It installs the latest version of Drupal 8 to /var/www/html. Drocker assumes that for your actual Drupal container, you will create a Dockerfile based on this image. This Docker file should `COPY` in your custom code and nothing else. This means you can update your Drupal codebase just by rebuilding your container.
- drocker-drupal-7
  - Same as drocker-drupal-8, but for Drupal 7.
- `drocker`
  - `drocker` is simple command line tool (written for bash) used to manage the lifecycle of your local development. Run `drocker help` to learn more about its commands.
