#!/bin/bash -e

script_dir=$(dirname "$(readlink -f "$0")")

source params.sh

$script_dir/default.sh stop $ZAPUSK_DEBUG

# для работы внешности, да и внутренних скриптов, все должно быть таки примонтировано..
# chroot-tool.sh on -d "$chroot_dir"
# но оно будет примонтировано - в результате выполнения stop

# это внутренность чруты сколлапсирует
$script_dir/default.sh destroy $ZAPUSK_DEBUG

# а это внешность.. на уровне host (это отличается от внутренности чруты)
zapusk destroy --zdb "$chroot_dir/chroot.d" --state_dir "$chroot_dir/chroot.d/_state.host" $ZAPUSK_DEBUG

# ну и выключим ея
chroot-tool.sh off -d "$chroot_dir"

# и уберем в архив
NOW=$(printf "%(%F_%H%M%S)T")
arcdir="$chroots_archive_dir/$chroot_name-$NOW/"
mkdir -p "$arcdir"
mv "$chroot_dir" "$arcdir"

echo "Chroota destroyed. archive dir=$arcdir"

