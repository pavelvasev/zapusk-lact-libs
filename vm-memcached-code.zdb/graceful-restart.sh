#!/bin/bash

# chroota.zdb always calls restart after apply
# idea is to skip restart if it is not required

if ! /etc/init.d/memcached status; then
  echo "memcached status returned non-zero, staring it"
  cp -f /etc/memcached.conf memcached.started.conf
  /etc/init.d/memcached start
  exit $?
fi

if test ! -f memcached.started.conf; then
  echo "no saved conf - restarting"
  cp -f /etc/memcached.conf memcached.started.conf
  /etc/init.d/memcached restart
  exit $?
fi

if cmp -s /etc/memcached.conf memcached.started.conf; then
  echo "NOTE. memcached.conf was not changed, and memcache is running. We skip restart to care on continuous operation."
  exit 0
else
  echo "conf differs - restarting"
  cp -f /etc/memcached.conf memcached.started.conf
  /etc/init.d/memcached restart
  exit $?
fi
