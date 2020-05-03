#!/bin/bash -e

source params.sh
cmd=$*

zapusk $cmd --zdb box $ZAPUSK_DEBUG
