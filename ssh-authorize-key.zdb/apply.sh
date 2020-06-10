#!/bin/bash -e

source params.sh

test ! -z "$user"
test ! -z "$content"

tgt=~$user/.ssh/authorized_keys

if test -f deployed-key; then
  k = $(cat deployed-key)
  if test "$k" = "$content" && grep -qxFs "$content" "$tgt"; then
    echo key already installed
    exit 0
  fi
  # ключ установлен, да не тот
  # надобно бы удалить
  $zdb_dir/destroy.sh
fi

grep -qxFs "$content" "$tgt" || echo "$content" | tee --append "$tgt"

echo key installed

#-q be quiet
#-x match the whole line
#-F pattern is a plain string
#-s ok on errors
# + https://stackoverflow.com/a/43145524

# запомнили память
echo "$content" > deployed-key