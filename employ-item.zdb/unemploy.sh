#!/bin/bash -e

source params.sh

copath="$1"

#zapusk unemploy --zdb $target $ZAPUSK_DEBUG --a "*/copath=$copath" --a "*/*/copath=$copath"
copath=$(readlink -f employed-content)
zapusk unemploy --zdb $target $ZAPUSK_DEBUG --a "*/copath=$copath" --a "*/*/copath=$copath"
