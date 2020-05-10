#!/bin/bash -e

source params.sh

# первый аргумент надо отбросить - там собственно чрута
copathes=($1) # make arr
copathes=("${copathes[@]:1}") # slice from 2nd element to end of arr

to_employ=""

for i in "$copathes"
do
#  echo "checking $i"
  k="employed-$(basename $i)"
  if ! cmp -s "$i" "$k"; then
    echo "Employ self: file $i differs, re-employing it."
    to_employ="$to_employ $(readlink -f $i)"
    cp -f "$i" "$k"
  else
    # йа не знаю как сделать || в баше
    # echo "Employ self: file already employed. btw ZAPUSK_FORCE=$ZAPUSK_FORCE"
    if test ! -z "$ZAPUSK_FORCE"; then
      echo "Employ self: force flag, re-employing."
      to_employ="$to_employ $(readlink -f $i)"
      cp -f "$i" "$k"
#    else
      #echo "Employ self: file $i have no dirrerence, skipping employ for $global_name"
    fi
  fi
  # do whatever on $i
done

#echo "EE: to_employ=$to_employ"

if test ! -z "$to_employ"; then
#  echo "EE: spawning employ into box"
#  echo zapusk employ --zdb box $ZAPUSK_DEBUG --a "*/copath=$to_employ" --a "*/*/copath=$to_employ" --a "*/colevel=1" --a "*/*/colevel=1"
  zapusk employ --zdb box $ZAPUSK_DEBUG --a "*/copath=$to_employ" --a "*/*/copath=$to_employ" --a "*/colevel=1" --a "*/*/colevel=1"
fi

# первая */copath - чтобы передавалось в компоненты..
# вторая */*/copath - чтобы передавалось в компоненты компонент.. типа когда
# вызываем host-ftp, то он имеет vstptd-server, а тот имеет employ внутри,
# так вот нам надо достучаться до этого employ-а снаружи получается.. как-то так..
# возможно стоит сделать что-то типа copath! где воскл знак означает пропихивать в компоненты