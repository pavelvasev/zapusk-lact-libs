#!/bin/bash -e

if test ! -f deployed-key; then
  echo "seems key not deployed"
  exit 0
fi

source params.sh

k=$(cat deployed-key)
test ! -z "$user"
tgt=$(eval echo "~$user/.ssh/authorized_keys")

# ладно уж..
#deployed_content=$(cat deployed-key)
#if ! grep -qxFs "$deployed_content" "$tgt"; then
#  echo "do not see key in $tgt"
#  exit 0
#fi

# вытащили все, что не про наш ключ, во времянку
grep -v "$k" "$tgt" >tmpkeys
# скопировали с сохранением прав исходного файла
cp --preserve tmpkeys "$tgt"
# удалили времянку
rm tmpkeys

# ну и удалили память
rm deployed-key

echo key removed
