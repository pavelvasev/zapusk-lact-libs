#!/bin/bash -e

source params.sh

if test -z "$mode"; then
  echo mode param is blank!
  exit 5
fi

for i in $list; do
  chmod $mode "$i"
done