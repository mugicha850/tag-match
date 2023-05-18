#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid
#bundle exec rails db:create RAILS_ENV=production
#bundle exec rails db:migrate RAILS_ENV=production
#bundle exec rails db:seed RAILS_ENV=production

# Then exec the container's main process (what's set as CMD in the Dockerfile).

case "$RAILS_ENV" in
  "production")
    # `RAILS_ENV`が`production`の場合の処理
    bundle exec rails assets:precompile RAILS_ENV=production
    echo "Running production code"
    ;;
  "development")
    # `RAILS_ENV`が`development`の場合の処理
    bundle exec rails assets:precompile RAILS_ENV=development
    echo "Running development code"
    ;;
  *)
    # それ以外の場合の処理
    echo "Unknown environmentです。"
    ;;
esac


exec "$@"
