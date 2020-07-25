#!/bin/bash -e

# Встраивает записи, переданные в employ в аргументах, в её первый аргумент.

source params.sh

# первый аргумент надо отбросить - там собственно чрута
copathes=($1) # make arr
#copathes="${copathes[@]:1}" # slice from 2nd element to end of arr

#echo "EMPLOY-SELF-2: copathes=$copathes"

# Идея - накопить тело для встраивания и заодно накопить контрольную сумму

boxlink=$(readlink -f box.zdb)
sum="this file is just for checksum, do not worry."
to_employ=""
content=""
level=0
for i in "${copathes[@]:1}"
do
#  echo "i=$i"
  ffi=$(readlink -f "$i")
  item_content=$(cat "$i")
  
  component_guid=$(sed -n 's/global_name=//p' $i)
  
  k="employ-$(basename $i)"
  content="
$content
####### employ-the-$component_guid
type=employ-item
file=$ffi
target=$boxlink
level=$level
"
  sum="$sum
$item_content"
  ((level=level+1))
done

sum="$sum$content"

echo "$sum" >to-employ

#echo "to-employ saved as: $sum"

if test -z "$ZAPUSK_FORCE"; then
if cmp -s "to-employ" "already-employed"; then
  echo "Employ self: no difference, already employed same thing."
  exit 0
fi
fi

echo "Employ self: differs, re-employing."

mkdir -p box.employ.zdb
echo "$content" > box.employ.zdb/20-self-employ.ini

echo "state_dir=../_box.employ.state">box.employ.zdb/zapusk.conf

  zapusk apply --zdb box.employ.zdb $ZAPUSK_DEBUG
  
echo "$sum" >already-employed
  
  # --a "*/copath=$to_employ" --a "*/*/copath=$to_employ" --a "*/colevel=1" --a "*/*/colevel=1"
#fi

# первая */copath - чтобы передавалось в компоненты..
# вторая */*/copath - чтобы передавалось в компоненты компонент.. типа когда
# вызываем host-ftp, то он имеет vstptd-server, а тот имеет employ внутри,
# так вот нам надо достучаться до этого employ-а снаружи получается.. как-то так..
# возможно стоит сделать что-то типа copath! где воскл знак означает пропихивать в компоненты