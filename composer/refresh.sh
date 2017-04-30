#!/bin/bash

set -e

main () {
  getItems | copy | search | replace
}

getItems () {
  printf  "%s\n%s\n%s" "drupal-cli" "drupal-testing" "nginx"
}

copy () {
  parallel "cp -r ../{} ./; echo ./{}"
}

search () {
  parallel "grep -rl '/var/www/html' {}"
}

replace () {
  parallel sed -i {} -e 's@/var/www/html@/var/www/web@g'
}

main $@
