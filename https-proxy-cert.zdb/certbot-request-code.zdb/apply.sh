#!/bin/bash -e

source params.sh

if test -z "$domains"; then
  echo "domains var is blank!"
  exit 5
fi

if test -z "$webroot_dir"; then
  echo "webroot_dir var is blank!"
  exit 5
fi

if test -z "$email"; then
  echo "email var is blank!"
  exit 5
fi

s=""
for d in $domains; do
 s="$s -d $d"
done

certbot certonly --noninteractive --agree-tos --email $email --webroot -w $webroot_dir $s
