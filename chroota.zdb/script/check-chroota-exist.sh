#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh

if test -d $chroot_dir && test -d $chroot_dir/chroot.d; then
  exit 0
else
  exit 100
fi
