#!/bin/bash -e

source params.sh
cmd=$*

zapusk $cmd --zdb box.zdb $ZAPUSK_DEBUG
