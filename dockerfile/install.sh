#!/bin/bash

if [ -e .env ]; then
  source .env
fi

: {RM_VERSION?"need to set redmine version RM_VERSION, see README.md"}

: ${ROOT=/root}
: ${ROOT_SRC=$ROOT/redmine-$RM_VERSION-stable}
: ${RM_USER=redmine}
: ${RM_DST=/redmine}
: ${RM_CONF_DIR=$RM_DST/config}
: ${RM_FILES_DIR=$RM_DST/files}
: ${ROOT_FILES_DIR=$ROOT/files}
: ${RM_LOG_DIR=$RM_DST/log}
: ${ROOT_LOG_DIR=$ROOT/log}
: ${RM_PLUGIN_DIR=$RM_DST/plugins}
: ${ROOT_PLUGIN_DIR=$ROOT/plugins}
: ${RM_PIASSETS_DIR=$RM_DST/public/plugin_assets}
: ${U_PID_DIR=$RM_DST/pids}

su -c "$ROOT/copy.sh" -m -s /bin/bash $RM_USER
cd $RM_DST
source /usr/local/share/chruby/chruby.sh
chruby 2.0
bundle install --without test

