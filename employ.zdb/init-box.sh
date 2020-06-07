#!/bin/bash -e

mkdir -p box.zdb
echo "############## horse" > box.zdb/10-horse.ini
cat arg_0.ini >> box.zdb/10-horse.ini

