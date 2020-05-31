#!/bin/bash

cp -f /etc/init.d/memcached.conf memcached.started.conf

/etc/init.d/memcached start
