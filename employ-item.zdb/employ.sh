#!/bin/bash -e

source params.sh

copath=$1
colevel=$2

if test -z "$colevel"; then
  echo "employ/employ.sh: colevel not specified!"
  exit 1
fi

((colevel=colevel+1))

zapusk employ --zdb $target $ZAPUSK_DEBUG --a "*/copath=$copath" --a "*/*/copath=$copath" --a "*/colevel=$colevel" --a "*/*/colevel=$colevel"

# первая */copath - чтобы передавалось в компоненты..
# вторая */*/copath - чтобы передавалось в компоненты компонент.. типа когда
# вызываем host-ftp, то он имеет vstptd-server, а тот имеет employ внутри,
# так вот нам надо достучаться до этого employ-а снаружи получается.. как-то так..

cat "$copath" >employed-content