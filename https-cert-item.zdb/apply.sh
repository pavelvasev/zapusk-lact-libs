#!/bin/bash -e

source params.sh

if test -z "$domains"; then
  echo "domains var is blank!"
  exit 5
fi

if test -z "$webroot_dir"; then
  echo "webroot_dir var is blank!"
  exit 5
fi

# вроде как не надо стало, см ниже
#if test -z "$email"; then
#  echo "email var is blank!"
#  exit 5
#fi

s=""
for d in $domains; do
 s="$s -d $d"
 # следует ли их экранировать?
done

#certbot certonly --noninteractive --agree-tos --email \"$email\" --webroot -w $webroot_dir $s
# чудеса - почему-то оно в кавычках перестало работать.
# без кавычек отстой конечно, но пока так... ладно хоть в чруте это все происходит..
# это рабочий:
# certbot certonly --noninteractive --agree-tos --email $email --webroot -w $webroot_dir $s

# https://eff-certbot.readthedocs.io/en/stable/using.html#configuration-file
# нашелся вот вариант:
certbot certonly --noninteractive --agree-tos --register-unsafely-without-email --webroot -w $webroot_dir $s

