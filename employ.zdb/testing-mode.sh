#!/bin/bash -e

# Назначение: провести testing-вызов для компонент, не разворачивая их.

# Основная идея - скопируем первый аргумент в папку папку testing.zdb,
# а последующие передадим ему как аргументы employ_files, и пусть разбирается.
# Ну мол такой протокол.

source params.sh

T=testing.zdb

rm -rf $T/*
mkdir -p $T

first=$1
echo "##################### first" >>$T/first.ini
cat $first >>$T/first.ini
echo "state_dir=_state" >$T/zapusk.conf

for ee in $2 $3 $4 $5 $6 $7 $8 $9
do
  if test ! -z "$ee"; then
    employ_files="$employ_files $(readlink -f $ee)"
  fi
done

# echo "employ_files=$employ_files"

# надо чтобы встроенный employ мог бы это подхватить
export employ_files="$employ_files"

zapusk testing --zdb $T $ZAPUSK_DEBUG
