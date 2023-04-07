#!/usr/bin/env bash
rails db:migrate
chmod -R 777 storage
/usr/sbin/apache2ctl -D FOREGROUND