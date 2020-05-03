#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

cmd="$*"
source params.sh

if test -z "$ZAPUSK_DEFERRED_PATH"; then
  echo "chroota::deferred.sh: ZAPUSK_DEFERRED_PATH var is blank!"
  exit 1
fi

#fn =$ZAPUSK_DEFERRED_PATH/$global_name-$cmd.ini
#echo "type=os
#apply=/etc/init.d/$global_name $cmd && rm -f '$fn'"
#" > fn

echo "$global_name-$cmd=/etc/init.d/$global_name $cmd" >>$ZAPUSK_DEFERRED_PATH