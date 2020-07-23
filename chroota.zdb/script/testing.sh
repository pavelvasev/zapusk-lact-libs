#!/bin/bash -e

# Выполняет тестирование содержимого чруты в режиме testing
# В этом режиме все содержимое скопировано в отдельную папку
# указанную аргументом arg_files_dir

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh
machine_root_dir="$chroot_dir"

test ! -z "$arg_files_dir"

for f in $arg_files_dir/*.ini
do
  echo "machine_root_dir=$chroot_dir" >>$f
  echo "employ_name=$global_name" >>$f
done

echo "state_dir=_state" > "$arg_files_dir/zapusk.conf"

echo "TESTING: chroota-context [$machine_root_dir] begin"
zapusk testing --zdb "$arg_files_dir" 
zapusk system-update-testing --zdb "$arg_files_dir"
echo "TESTING: chroota-context [$machine_root_dir] finish"

zapusk prehost-testing --zdb "$arg_files_dir"
zapusk host-testing --zdb "$arg_files_dir"

