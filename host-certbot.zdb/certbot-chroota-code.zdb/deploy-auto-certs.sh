#!/bin/bash -e

# https://github.com/certbot/certbot/issues/1201#issuecomment-154046927
# https://certbot.eff.org/docs/using.html#pre-and-post-validation-hooks

# копирует сертификаты из каталога, куда их кладет certbot
# в каталог, где их использует haproxy (/data/https-proxy/auto-certs)
# при копировании переименовывает их в имя домена и объединяет в 1 файл
# ибо се надо haproxy для работы

source params.sh

if test -z "$results_dir"; then
  echo "results_dir var is blank!"
  exit 5
fi

echo "deploying letsencrypt items into $results_dir"

for dir in $(ls -d /etc/letsencrypt/live/*/); do
  bd=$(basename "$dir")
  echo "deploying $bd"
  cat "${dir}privkey.pem" "${dir}fullchain.pem" > "$results_dir/$bd-fullkeychain.pem"
done
