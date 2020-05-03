#!/bin/bash
set -e

source params.sh

if test ! -z "$global_name"
then
  cf="/etc/cron.d/zapusk_$global_name"
  echo "cron file name $cf"
  if test -f "$cf"; then
    rm "$cf"
    echo "removed cron file, ok"
  else
    echo "no cron file found, ok"
  fi
fi
