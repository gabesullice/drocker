#!/bin/bash

set -e

main () {
  get_makefile
  get_drupal_version
  make init
}

get_drupal_version () {
  read -p "Which version of Drupal will this be for? [8]: " DRUPAL_VERSION
  if ![[ $DRUPAL_VERSION ]]; then DRUPAL_VERSION=8; fi
  export DRUPAL_VERSION
  printf "\n"
}

get_makefile () {
  curl -sS -Lo ./Makefile https://raw.githubusercontent.com/gabesullice/drocker/master/bootstrap/Makefile
}

main $@
