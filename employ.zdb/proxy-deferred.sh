#!/bin/bash -e

source params.sh
cmd=$*

arg0_component_guid=$(sed -n 's/global_name=//p' arg_0.ini)

if test -z "$ZAPUSK_DEFERRED_PATH"; then
  echo "employ::proxy-deferred.sh: ZAPUSK_DEFERRED_PATH var is blank!"
  exit 1
fi

echo "$arg0_component_guid-$cmd=zapusk $cmd --zdb $state_dir/box $ZAPUSK_DEBUG" >>$ZAPUSK_DEFERRED_PATH
# echo "REG_DEF: $arg0_component_guid-$cmd=zapusk $cmd --zdb $state_dir/box $ZAPUSK_DEBUG"

# zapusk $cmd --zdb box $ZAPUSK_DEBUG
