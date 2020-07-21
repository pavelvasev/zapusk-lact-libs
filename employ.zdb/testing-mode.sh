#!/bin/bash -e

# Назначение: провести testing-вызов для компонент, не разворачивая их.

# Основная идея - скопируем все аргументы в папку testing.zdb
# и вызовем на ней команду testing

# На самом деле это хак и реализация логики для чрут. Ибо для других
# типов может быть другое поведение. Но пока проще сделать так.

source params.sh

T=testing.zdb

mkdir -p $T
rm -rf $T/*

copathes=($1) # make arr
for i in "${copathes[@]:0}"
do
#  echo "i=$i"
  item_content=$(cat "$i")
  component_guid=$(sed -n 's/global_name=//p' $i)
  
  Q=$T/$(basename "$i" .ini).ini
#  cp $i $T/$(basename "$i")
  echo "######## $component_guid" >$Q
  echo "$item_content" >>$Q

  #################### вычисление необходимых переменных
  # которые мы дозапишем в информацию к компонентам
  # и еще используем далее
  # 1) назначим первый попавшийся component_guid в employ_name (и это правильно)
  if test -z "$employ_name"; then 
    employ_name=$component_guid; 
    always_append="$always_append
employ_name=$employ_name"
  fi
  # 2) вычислим chroot_dir. Вообще это хак, представитель из чрут тут
  if test -z "$chroot_dir"; then
    its_type=$(sed -n 's/type=//p' $i)
#    if test "$its_type" = "chroota"; then
      its_chroot_dir=$(sed -n 's/chroot_dir=//p' $i)
      if test -z "$its_chroot_dir"; then
        its_chroot_dir=$chroota_base_dir/$component_guid
      fi
      chroot_dir=$its_chroot_dir
      always_append="$always_append
machine_root_dir=$chroot_dir"
      export ZAPUSK_TESTING_CONTEXT="[chroota:$chroot_dir]"
#    fi
  fi
  ####################
#  echo "employ_name=$employ_name" >>$Q
#  echo "machine_root_dir=$chroot_dir" >>$Q
  echo "$always_append" >>$Q
done

echo "state_dir=_state" >$T/zapusk.conf

if test -z "$ZAPUSK_TESTING_CONTEXT"; 
then
zapusk testing --zdb $T $ZAPUSK_DEBUG
else
echo "$ZAPUSK_PADDING" "TESTING: context $ZAPUSK_TESTING_CONTEXT start"
zapusk testing --zdb $T $ZAPUSK_DEBUG
echo "$ZAPUSK_PADDING" "TESTING: context $ZAPUSK_TESTING_CONTEXT finish"
fi