#!/bin/bash -e

source params.sh

mkdir -p box
echo "############## horse" > box.zdb/10-horse.ini
cat arg_0.ini >> box.zdb/10-horse.ini
# install arg_0.ini box.zdb/10-horse.ini

echo "state_dir=../_box.state" > box.zdb/zapusk.conf

zapusk create --zdb box.zdb $ZAPUSK_DEBUG
