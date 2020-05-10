#!/bin/bash -e
# Создает локальную чруту с заданным именем

source params.sh

mkdir -p "$chroot_dir/chroot.d"
mkdir -p "$chroot_dir/chroot.d/bindings.params"
mkdir -p "$chroot_dir/chroot.d/_state"
mkdir -p "$chroot_dir/chroot.d/_state.host"
mkdir -p "$chroot_dir/chroot.d/_state.prehost"

script_dir=$(dirname "$(readlink -f "$0")")
install "$script_dir/chroot.d.template/conf.sh" "$chroot_dir/chroot.d/conf.sh"
install "$script_dir/chroot.d.template/zapusk.conf" "$chroot_dir/chroot.d/zapusk.conf"
install "$script_dir/chroot.d.template/stop" "$chroot_dir/chroot.d/stop"
# install "$script_dir/chroot.d.template/main.ini" "$chroot_dir/chroot.d/main.ini"

echo "BINDINGS_ZAPUSK='src:$zapusk_tool_dir tgt:/zapusk-tool'" >>"$chroot_dir/chroot.d/conf.sh"

# echo "Finished. All ok"