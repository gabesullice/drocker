#!/bin/bash

read -p "Which version of Drupal will this be for? [8]: " DRUPAL_VERSION
printf "\n"
curl -Lo ./Makefile https://raw.githubusercontent.com/gabesullice/drocker/master/bootstrap/Makefile
make init
