#!/bin/bash -e

source params.sh

test ! -z "$user"
test ! -z "$content"

# eval echo ~username некий способ вычислить домашний каталог пользователя
tgt=$(eval echo "~$user/.ssh/authorized_keys")

if test -f deployed-key; then # тэкс, уже что-то ставили ранее
  k=$(cat deployed-key)
  if test "$k" = "$content"; then  # и то что ставили ранее совпадает с запрошенным сейчас
    if grep -qxFs "$content" "$tgt"; then # и в файле то оно уже есть
      echo key already installed # ну и хорошо
      exit 0
    fi
    # но в файле этого нет
  else
    # то что ставили ранее - не совпадает с тем, что просят сейчас
    # надобно бы удалить
    $zdb_dir/destroy.sh
  fi
fi

# вроде бы как tee --append пишет лучше, потому что мол он в sudp режиме сработает, а >> нет
# и второй приятный подарок - он как-то разбирается с переводом строк
# (если файл не кончается переводом строки - он его добавляет, я так вижу сейчас)
grep -qxFs "$content" "$tgt" || echo "$content" | tee --append "$tgt" >/dev/null

echo key installed

#-q be quiet
#-x match the whole line
#-F pattern is a plain string
#-s ok on errors
# + https://stackoverflow.com/a/43145524

# запомнили память
echo "$content" > deployed-key