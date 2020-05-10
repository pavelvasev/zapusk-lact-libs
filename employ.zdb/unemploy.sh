#!/bin/bash -e

source params.sh

copath="$1"

zapusk unemploy --zdb box $ZAPUSK_DEBUG --a "*/copath=$copath" --a "*/*/copath=$copath"