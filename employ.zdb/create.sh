#!/bin/bash -e

# todo сделать проверку не пора ли обновить (см. также [once]-фильтр сюда не пускает)
# если обновили - то надо все employ заново делать, по идее.
# потому что смена global_name у первого аргумента это серьезно, это может чрута-каталог даже поменялся
# а мы и не знаем..

source params.sh

mkdir -p box.zdb
echo "############## horse" > box.zdb/10-horse.ini
cat arg_0.ini >> box.zdb/10-horse.ini
# install arg_0.ini box.zdb/10-horse.ini

echo "state_dir=../_box.state" > box.zdb/zapusk.conf

#if test ! -f already-created-arg-0; then
  zapusk create --zdb box.zdb $ZAPUSK_DEBUG
#  echo 1 > already-created-arg-0
#fi

