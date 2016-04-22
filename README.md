Drocker
----

Drocker is a collection of command-line tools and Docker images for developing and running containerized Drupal sites.

Its philosophy is minimalistic and bare-bones. Drocker tries its best to get out of your way. Just making the tedious things simpler.

## Overview
Drocker has three main components. First, is a suite of base images, like nginx, php-fpm, etc. All of Drocker's images are single-process containers, no supervisord funny-business. This choice allows you to orchestrate things however you choose. Although, for local orchestration we encourage you to use `docker-compose`. Drocker has no opinion on how you should orchestrate your containers in production.

Second, Drocker ships with two Drupal specific images (built off the php-fpm base image). The intent here is to allow you to create Dockerfiles from these images, installing only your custom code and modifications. By doing so, you can easily "inherit" updates from the Drupal and php-fpm images.

Finally, Drocker ships with a command line tool (rather unoriginally named `drocker`). This tool makes it easy to control the lifecycle of your local development, from running drush commands, importing databases, to fixing permissions issues.

## Quickstart
If you already have docker and docker-compose installed, you can follow these steps to get up and running:

```sh
# Create a directory for you project
mkdir mynewproject
cd mynewproject

# Download and install configuration files.
curl -sS -Lo ./install.sh https://raw.githubusercontent.com/gabesullice/drocker/master/bootstrap/install.sh \
  && chmod u+x ./install.sh \
  && ./install.sh \
  && rm ./install.sh
# The above will prompt you for a drupal version, either "7" or "8".

# Now that you have the skeleton, go ahead and put the Drupal root in a subdirectory named "docroot".
git clone <your git upstream> ./docroot
```

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
