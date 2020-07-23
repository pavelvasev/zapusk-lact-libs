#!/bin/bash -e

# Выполняет тестирование содержимого чруты в режиме testing
# В этом режиме все содержимое скопировано в отдельную папку
# указанную аргументом arg_files_dir

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh
machine_root_dir="$chroot_dir"

T=args.zdb

rm -rf $T/*
mkdir -p $T

# echo "employ_files=$employ_files"

num=0
for f in $employ_files
do
  component_guid="guid_$num"
  Q=$T/$num.ini # todo если больше 9?
  #item_content=$(cat "$f")
  #component_guid=$(sed -n 's/global_name=//p' "$f")
  #Q=$T/$(basename "$f" .ini).ini

  echo "######## $component_guid" >$Q
  cat "$f" >>$Q
  #echo "$item_content" >>$Q
  echo "machine_root_dir=$chroot_dir" >>$Q
  echo "employ_name=$global_name" >>$Q
  ((num=num+1))
done

echo "state_dir=_state" > "$T/zapusk.conf"

echo "############################ testing-start
[commands]
open-context=testing
[testing]
code=context-chroota-begin
comment=Следующие тесты в контексте чруты 44
arg_path=$chroot_dir
############################ testing-finish
[commands]
close-context=testing
[testing]
code=context-chroota-finish
comment=закончились тесты в контексте чруты
arg_path=$chroot_dir" > "$T/testing-context.ini"

#echo "TESTING: chroota-context [$machine_root_dir] begin"

zapusk open-context --zdb "$T"
zapusk testing --zdb "$T" 
zapusk system-update-testing --zdb "$T"
zapusk close-context --zdb "$T"
#echo "TESTING: chroota-context [$machine_root_dir] finish"

zapusk prehost-testing --zdb "$T"
zapusk host-testing --zdb "$T"

