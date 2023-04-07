#!/bin/bash

chmod -R 777 storage
/usr/sbin/apache2ctl -D FOREGROUND

bundle exec puma -C config/puma.rb