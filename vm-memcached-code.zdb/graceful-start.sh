#!/bin/bash

cp -f /etc/memcached.conf memcached.started.conf

/etc/init.d/memcached start
