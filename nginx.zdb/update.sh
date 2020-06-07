#!/bin/bash -e

source params.sh

if test ! -z "$remove_default_site"
then
  echo removing /etc/nginx/sites-enabled/default
  rm -f /etc/nginx/sites-enabled/default
fi

if test ! -z "$remove_trash_snippets"
then
  echo removing trash from /etc/nginx/snippets/
  test -f /etc/nginx/snippets/fastcgi-php.conf && mv -f /etc/nginx/snippets/fastcgi-php.conf fastcgi-php.conf.saved
  test -f /etc/nginx/snippets/snakeoil.conf && mv -f /etc/nginx/snippets/snakeoil.conf snakeoil.conf.saved
fi

echo nginx updated