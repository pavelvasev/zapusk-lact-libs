#!/bin/bash -ex
source params.sh
test ! -z "$size_mb"
test ! -z "$path"
if test -f "$path"; then
  echo "swap file already exist. skipping"
  exit 0
fi

dd if=/dev/zero of="$path" bs=1M count="$size_mb" status=progress
chmod 0600 "$path"
echo "generated, calling mkswap"
mkswap "$path"
echo "turning swapon"
swapon "$path"
swapon --show
