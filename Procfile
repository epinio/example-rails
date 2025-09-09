web: chmod 777 server.pid && chown $USER:$USER server.pid && bundle exec rails db:prepare && bundle exec puma -t 5:5 -p ${PORT:-3000} -e production
