#!/bin/bash -e

source params.sh

if test -z "$user"; then
  echo "user param is not specified!"
  exit 5
fi

for i in $list; do
  chown -R "$user:$user" "$i"
done