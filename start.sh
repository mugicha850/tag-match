#!/bin/bash

chmod -R 777 storage


bundle exec puma -C config/puma.rb -e production