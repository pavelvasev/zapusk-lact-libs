#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh

if test -z "$(ls -A $chroot_dir/chroot.d/extras)"; then
  echo "Chroota have no extras."
else
  echo "Chroota have extras."
  exit 100
fi
