#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh
copathes=($1)
colevel="$2"
if test -z "$colevel"; then
  echo "choota/employ-component.sh: colevel not specified!"
  exit 1
fi

# colevel приходит к нам сверху в чруту
# мы прибавим к нему 10 и получим результат.

((p=colevel+10))

for copath in "${copathes[@]}"
do

  component_type=$(sed -n 's/type=//p' $copath)
  component_type_dir=$(sed -n 's/type_dir=//p' $copath)
  component_guid=$(sed -n 's/global_name=//p' $copath)

  echo "BINDINGS_type_${component_type//-/_}='src:$component_type_dir tgt:/chroot.d/$component_type.zdb'" >"$chroot_dir/chroot.d/bindings.params/$component_guid.sh"

  cat $copath | grep BINDINGS_| sed -E "s/^(.+)=(.+)$/\1_${component_guid//-/_}='\2'/" >>"$chroot_dir/chroot.d/bindings.params/$component_guid.sh"
#  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ SED@"
#  cat $copath | grep BINDINGS_| sed -E "s/^(.+)=(.+)$/\1_${component_guid//-/_}='\2'/"
#  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
#  echo "bwt orig is"
#  cat $copath
#  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # вытаскиваем BINDINGS_ штучки из компонента, приписываем к ним идентификатор уникальный для copath, и тыркаем это в правильное место
  # || true
  
  install "$copath" "$chroot_dir/chroot.d/$p-$component_guid.ini"
  
  # добавим наш любимый отныне заголовок ####
  sed -i "1s;^;##################### $component_guid\n;" "$chroot_dir/chroot.d/$p-$component_guid.ini"
  
#  echo "prehost_state_dir=/chroot.d/_state.prehost/$component_guid/" >>"$chroot_dir/chroot.d/$p-$component_guid.ini"
  # добавим значения, итак упомянутые в params.ini - но сами собой они в глубину не передаются (а может стоит?)
  echo "machine_root_dir=$chroot_dir" >>"$chroot_dir/chroot.d/$p-$component_guid.ini"
  echo "chroot_dir=$chroot_dir" >>"$chroot_dir/chroot.d/$p-$component_guid.ini"
  echo "employ_name=$global_name" >>"$chroot_dir/chroot.d/$p-$component_guid.ini"

done