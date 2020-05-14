#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")
cmd="$*"

source params.sh

#echo --------------------params.sh
#cat params.sh
#echo --------------------

#echo -------------------- cmd=
#echo "$cmd"
#echo --------------------

# chroot-tool path
# chroot_tool=chroot-tool.sh
# echo "chroot_dir=$chroot_dir"

$chroot_tool run "/zapusk-tool/zapusk $cmd --zdb /chroot.d --state_dir /chroot.d/_state --deferred-master $ZAPUSK_DEBUG" -d "$chroot_dir"
