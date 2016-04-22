#!/bin/bash

set -e

main () {
  get_makefile
  local drupal_version=$(get_drupal_version)
  initialize $drupal_version
  cleanup
}

initialize () {
  DRUPAL_VERSION=$1 make init
}

cleanup () {
  rm ./Makefile
}

get_drupal_version () {
  read -p "Which version of Drupal will this be for? [8]: " DRUPAL_VERSION
  printf "\n"
  echo ${DRUPAL_VERSION:="8"}
}

get_makefile () {
  curl -sS -Lo ./Makefile https://raw.githubusercontent.com/gabesullice/drocker/master/bootstrap/Makefile
}

main $@
