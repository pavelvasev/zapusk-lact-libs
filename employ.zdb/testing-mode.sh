#!/bin/bash -e

# Назначение: провести testing-вызов для компонент, не разворачивая их.

# Основная идея - скопируем первый аргумент в папку папку testing.zdb,
# а последующие в подпапку components
# и вызовем на testing.zdb команду testing

# А дальше пусть оно там разбирается

source params.sh

T=testing.zdb

rm -rf $T/*
#mkdir -p $T
mkdir -p $T/args

echo "employ interna, $state_dir"

copathes=($1) # make arr
for i in "${copathes[@]:0}"
do
#  echo "i=$i"
  item_content=$(cat "$i")
  component_guid=$(sed -n 's/global_name=//p' $i)

  if test -z "$C_CREATED"; then
    Q=$T/$(basename "$i" .ini).ini
    C_CREATED=$Q
  else
    Q=$T/args/$(basename "$i" .ini).ini
  fi

  echo "######## $component_guid" >$Q
  echo "$item_content" >>$Q
done

# arg_files_dir собственная для этого employ
if test ! -z "$arg_files_dir"; then
echo "employ externa: $arg_files_dir"
shopt -s nullglob
for i in $arg_files_dir/*.ini
do
  Q=$T/args/x_$(basename "$i" .ini).ini
  cp "$i" "$Q"
#  echo "i=$i"
#  item_content=$(cat "$i")
#  component_guid=$(sed -n 's/global_name=//p' $i)

#  Q=$T/args/x_$(basename "$i" .ini).ini
#  echo "######## $component_guid" >$Q
#  echo "$item_content" >>$Q
done
fi

# export arg_files="$2 $3

# Мысль - может проще тупо создать из 1го аргумента zdb-программу,
# а остальные передать не копируя? Типа пусть там копируют..

echo "state_dir=_state" >$T/zapusk.conf

afd=$(readlink -f $T)/args
echo "arg_files_dir=$afd" >>$C_CREATED
export arg_files_dir=$afd

zapusk testing --zdb $T $ZAPUSK_DEBUG
