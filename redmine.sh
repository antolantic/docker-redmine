#!/bin/bash

if [[ ! -e .env ]]; then
  cp sample.env .env
fi

source .env

: ${RM_VERSION?"need to set redmine version RM_VERSION, see README.md"}

: ${RM_BRANCH=$RM_VERSION-stable}
: ${RM_DIR=$RM_BRANCH}

if [[ ! -v RAILS_ENV || "$RAILS_ENV" == development ]]; then
  if [[ ! -e $RM_DIR/db/development.sqlite ]]; then
    scripts/initialize.sh
  fi
else
  if [[ "$RAILS_ENV" == production && ! -e .production ]]; then
    scripts/initialize.sh
  fi
fi

scripts/redmine.sh

