#!/bin/bash -e

# todo сделать проверку не пора ли обновить (см. также [once]-фильтр сюда не пускает)
# если обновили - то надо все employ заново делать, по идее.
# потому что смена global_name у первого аргумента это серьезно, это может чрута-каталог даже поменялся
# а мы и не знаем..

echo "state_dir=../_box.state" > box.zdb/zapusk.conf
zapusk create --zdb box.zdb $ZAPUSK_DEBUG


