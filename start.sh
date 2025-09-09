#!/bin/bash

# Ensure the tmp directory exists and set ownership
mkdir -p tmp
chown -R $USER:$USER tmp

# Start the rails server
bundle exec rails db:prepare && bundle exec puma -t 5:5 -p ${PORT:-3000} -e production
