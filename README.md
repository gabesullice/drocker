# Drocker

Drocker is a collection of command-line tools and Docker images for developing and running containerized Drupal sites.

Its philosophy is minimalistic and bare-bones. Drocker tries its best to get out of your way. Just making the tedious things simpler.

## Overview
Drocker has three main components. First, is a suite of base images, like nginx, php-fpm, etc. All of Drocker's images are single-process containers, no supervisord funny-business. This choice allows you to orchestrate things however you choose. Although, for local orchestration we encourage you to use `docker-compose`. Drocker has no opinion on how you should orchestrate your containers in production.

Second, Drocker ships with two Drupal specific images (built off the php-fpm base image). The intent here is to allow you to create Dockerfiles from these images, installing only your custom code and modifications. By doing so, you can easily "inherit" updates from the Drupal and php-fpm images.

Finally, Drocker ships with a command line tool (rather unoriginally named `drocker`). This tool makes it easy to control the lifecycle of your local development, from running drush commands, importing databases, to fixing permissions issues.

## Installing the drocker command-line tool
The drocker cli is simply a shell script. You can install it however you normally install scripts. However, if you're new to that kind of thing, here's our recommended approach:

```sh
pushd $HOME
mkdir -p lib bin
git clone https://github.com/gabesullice/drocker.git ./lib/drocker
ln -sf $HOME/lib/drocker/command/drocker ./bin/drocker
which drocker || $(echo "PATH=$PATH:$HOME/bin" >> .bashrc)
popd
```

## Setting Up a Project
If you already have the drocker cli, docker and docker-compose installed, you can follow these steps to set up a new drocker site with one command:

```sh
# Create a directory for you project
mkdir mynewproject
cd mynewproject
drocker new
```

From here, you will have a basic Dockerfile and docker-compose.yml ready to go. You can make any modifications you need for your project in those, like extra shared volumes, overwriting `robots.txt`, etc.

Now, run `docker-compose build` to check that your Dockerfile builds correctly. If so, run `docker-compose up -d`. If everything went without a problem, you're all done! You can visit `127.0.0.1` to see your new site.

## Anti-Features
As is mentioned above, Drocker tries to be minimalistic and get out of your way. That means that there are some things that we just won't try to do for you. That said, most, if not all the features an opinionated VM might give you are completely possible to achieve and we have a [Wiki](https://github.com/gabesullice/drocker/wiki) to show you how to do those things yourself.

- PimpMyLog
  - We prefer `tail -f` _et al._ for streaming logs.
- Node.js
  - Build a Dockerfile for your node project or use someone's prebuilt image; add it to your `docker-compose.yml`
- MailCatcher/MailHog
  - Just add a container with one of these already installed to your `docker-compose.yml` file.
- PhpMySQL/Adminer
  - See above.
- Redis
  - See above.
- Ruby
  - Ick.

## Running on Mac or Windows
In order to use drocker on Mac or Windows, you'll need to install [Docker for Mac](https://docs.docker.com/docker-for-mac/) or [Docker for Windows](https://docs.docker.com/docker-for-windows/).

## Running on Linux
All you need to run Drocker instances on Linux is have the docker-engine and docker-compose installed.

## Components
- `drocker`
  - `drocker` is simple command line tool (written for bash) used to manage the lifecycle of your local development. Run `drocker help` to learn more about its commands.
- drocker-nginx
  - Contains a simple instance of NGINX configured to proxy to Drupal running as PHP-FPM.
- drocker-php-fpm
  - This image contains an installation of PHP 5.6 FPM with all the necessary PHP libs from running Drupal.
- drocker-drupal-cli
  - This image provides the latests versions of composer, drupal console, and drush. When you run `drocker connect`, you are dropped into a shell session in the container, which will be connected to your Drupal container via shared volumes.
- drocker-drupal-8
  - This image builds off drocker-php-fpm image. It installs the latest version of Drupal 8 to /var/www/html. Drocker assumes that for your actual Drupal container, you will create a Dockerfile based on this image. This Docker file should `COPY` in your custom code and nothing else. This means you can update your Drupal codebase just by rebuilding your container.
- drocker-drupal-7
  - Same as drocker-drupal-8, but for Drupal 7.
