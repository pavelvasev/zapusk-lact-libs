#!/bin/bash -ex
source params.sh
test ! -z "$size_mb"
test ! -z "$path"

# самая важная проверка - свап уже используется сей
  if swapon --show|grep "$path"; then
    echo "swap file seems used. skipping swapon call"
    exit 0
  fi

#if test -f "$path"; then
#  echo "swap file already exist. skipping file fill"
#  exit 0
#fi

  dd if=/dev/zero of="$path" bs=1M count="$size_mb" status=progress
  echo "generated, calling mkswap"
  mkswap "$path"

echo "changing to 0600"
chmod 0600 "$path"
echo "turning swapon"
swapon "$path"
swapon --show
