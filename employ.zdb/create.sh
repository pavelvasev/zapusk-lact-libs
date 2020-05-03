#!/bin/bash -e

source params.sh

mkdir -p box
echo "############## horse" > box/09-horse.ini
install arg_0.ini box/10-horse.ini

install "$zdb_dir/box-zapusk.conf_" box/zapusk.conf
install "$zdb_dir/box-main.ini_" box/main.ini

zapusk create --zdb box $ZAPUSK_DEBUG
