#!/bin/sh
set -e

if [ "$RAILS_ENV" == "development" ]; then
  # Remove a potentially pre-existing server.pid for Rails.
  rm -rf tmp/pids/server.pid

#  yarn config set cache-folder /tmp/yarn_cache
#  yarn config set yarn-offline-mirror /tmp/node_modules_cache
#  yarn config set yarn-offline-mirror-pruning true
#  yarn install --offline
elif [ "$RAILS_ENV" == "production" ]; then
  mv config/mongoid.yml.template config/mongoid.yml

  mkdir -p /data/logs
  touch /data/logs/zhuanti_production.log
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"