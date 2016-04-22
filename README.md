# Drocker

Drocker is a collection of command-line tools and Docker images for developing and running containerized Drupal sites.

Its philosophy is minimalistic and bare-bones. Drocker tries its best to get out of your way. Just making the tedious things simpler.

## Overview
Drocker has three main components. First, is a suite of base images, like nginx, php-fpm, etc. All of Drocker's images are single-process containers, no supervisord funny-business. This choice allows you to orchestrate things however you choose. Although, for local orchestration we encourage you to use `docker-compose`. Drocker has no opinion on how you should orchestrate your containers in production.

Second, Drocker ships with two Drupal specific images (built off the php-fpm base image). The intent here is to allow you to create Dockerfiles from these images, installing only your custom code and modifications. By doing so, you can easily "inherit" updates from the Drupal and php-fpm images.

Finally, Drocker ships with a command line tool (rather unoriginally named `drocker`). This tool makes it easy to control the lifecycle of your local development, from running drush commands, importing databases, to fixing permissions issues.

## Setting Up a Project
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

From here, you will have a basic Dockerfile and docker-compose.yml ready to go. You can make any modifications you need for your project in those, like extra shared volumes overwriting `robots.txt`, etc.

Now, run `docker-compose build` to check that your Dockerfile builds correctly. If so, run `docker-compose up -d`. If all goes well, you can move on to the final step.

You will need to confirm that Drupal's database connection is properly configured. Run `docker-compose ps` and note the name of your MySQL container (usually your current directory + `_mysql_1`. Open up your local settings file for Drupal in the `.data/drupal/settings` directory. A basic template will be there, but you should confirm that it is correct. The database host match the name of the mysql container that you're using.

If you're starting from scratch, you can now run Drupal's installer. If you're running an existing project, grab a copy of that projects db, decompress it if necessary and run `./drocker sql-import [FILE]`, where `[FILE]` is the path to your uncompressed SQL dump.

You're ready to go! Visit `localhost` in your browser to see how things went.

## Running on Linux
All you need to run Drocker instances on Linux is have the docker-engine and docker-compose installed.

## Running on Mac or Windows
Until Docker for Mac/Windows Native is publicly available, Drocker is also bundled with an incredibly minimalistic Vagrant setup. Unlike many other local development environments like Drupal VM, which suffer from slow local performance when running Drupal from a shared directory (NFS or Vagrant Sync), Drocker flips NFS sharing around. Your code should be stored "natively" in the virtual machine, the drockervm command will set up NFS to mount this directory locally. This greatly improves PHP's performance characteristics within the VM.

## Components
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
- `drocker`
  - `drocker` is simple command line tool (written for bash) used to manage the lifecycle of your local development. Run `drocker help` to learn more about its commands.
- `drockervm`
  - `drockervm` is simple command line wrapper around the vagrant command (written for bash). You can use this to create a VM that can run Docker and will set up code sharing between your machine and the VM. If you're using a VM, remember that all of the `drocker` commands above must be run from _inside_ the VM. You can SSH into the VM by running `drockervm ssh`.
