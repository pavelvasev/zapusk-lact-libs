#!/bin/bash -e

if test ! -f deployed-key; then
  echo "seems key not deployed"
  exit 0
fi

if test ! -f deployed-to-user; then
  echo "WARNING: deployed-to-user file blank... seems deploy broken - exiting."
  exit 0
fi

source params.sh

k=$(cat deployed-key)
kuser=$(cat deployed-to-user)
test ! -z "$kuser"
tgt=$(eval echo "~$kuser/.ssh/authorized_keys")

# ладно уж..
#deployed_content=$(cat deployed-key)
#if ! grep -qxFs "$deployed_content" "$tgt"; then
#  echo "do not see key in $tgt"
#  exit 0
#fi

# забекапили себе на всякий случай
cp --backup "$tgt" "authorized-keys-backup-$kuser"

# вытащили все, что не про наш ключ, во времянку
grep -v "$k" "$tgt" >tmpkeys || test "$?" == "1" 
# код 1 это норм, значит ничего не нашли.. т.е. все что там в файле у них лежит - попадается под наш матч.. странно это конечно..
# скопировали с сохранением прав исходного файла
cp --preserve tmpkeys "$tgt"
# удалили времянку
# rm tmpkeys

# ну и удалили память
rm deployed-key
rm deployed-to-user

echo "key removed from $tgt"

