web: mkdir -p tmp/pids && chmod -R u+w tmp && bundle exec rails db:prepare && bundle exec puma -t 5:5 -p ${PORT:-3000} -e production
