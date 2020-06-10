#!/bin/bash -e

if test ! -f deployed-key; then
  echo "seems key not deployed"
  exit 0
fi

k=$(cat deployed-key)
test ! -z "$user"
tgt=~$user/.ssh/authorized_keys

# вытащили все, что не про наш ключ, во времянку
grep -v "$k" "$tgt" tmpkeys
# скопировали с сохранением прав исходного файла
cp --preserve tmpkeys "$tgt"
# удалили времянку
rm tmpkeys

# ну и удалили память
rm deployed-key