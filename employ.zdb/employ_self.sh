#!/bin/bash -e

source params.sh

copath="$1"

if ! cmp -s "$copath" employed.last; then
  echo "Employ self: file differs, re-employing it."
  zapusk employ --zdb box $ZAPUSK_DEBUG --a "*/copath=$(readlink -f $copath)" --a "*/*/copath=$(readlink -f $copath)" --a "*/colevel=1" --a "*/*/colevel=1"
  cp -f "$copath" employed.last
else
  # йа не знаю как сделать || в баше
  # echo "Employ self: file already employed. btw ZAPUSK_FORCE=$ZAPUSK_FORCE"
  if test ! -z "$ZAPUSK_FORCE"; then
    echo "Employ self: force flag, re-employing."
    zapusk employ --zdb box $ZAPUSK_DEBUG --a "*/copath=$(readlink -f $copath)" --a "*/*/copath=$(readlink -f $copath)" --a "*/colevel=1" --a "*/*/colevel=1"
    cp -f "$copath" employed.last
  else
    echo "Employ self: file have no dirrerence, skipping employ for $global_name"
  fi
fi

# первая */copath - чтобы передавалось в компоненты..
# вторая */*/copath - чтобы передавалось в компоненты компонент.. типа когда
# вызываем host-ftp, то он имеет vstptd-server, а тот имеет employ внутри,
# так вот нам надо достучаться до этого employ-а снаружи получается.. как-то так..
# возможно стоит сделать что-то типа copath! где воскл знак означает пропихивать в компоненты