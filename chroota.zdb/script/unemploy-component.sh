#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh
copath=$1

component_guid=$(sed -n 's/global_name=//p' $copath)
local_file=$(find "$chroot_dir/chroot.d/" -type f -name "??-$component_guid.ini")

# вроде не надо - дальше кэт и так свалится
# дык он свалится - и мы свалимся
# echo CCCCC
if test ! -f "$local_file"; then
  echo "unemploy_component: local_file not found!!! path=$local_file"
  rm -f "$chroot_dir/chroot.d/bindings.params/$component_guid.sh"
  exit
fi

echo "========= chroota unemploying component:"
echo "copath=$copath"
echo "component_guid=$component_guid"
echo "local path=$local_file"
echo "======= local dump"
cat "$local_file"
echo "========================================"

# Вызвать дестрой - убрать софт, развернутый компонентой
# оказывается еще стоп надо. ибо коллапс не подразумевает стоп, как выяснилось.. 
# это ж логика чруты, то есть нашего текущего скрипта
$script_dir/default.sh stop --only $component_guid
$script_dir/default.sh destroy --only $component_guid
# Затем убрать упоминания о компоненте из запуск-базы развернутой чруты
rm -f "$local_file"
rm -f "$chroot_dir/chroot.d/bindings.params/$component_guid.sh"