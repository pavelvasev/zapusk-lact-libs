#!/bin/bash -e

source params.sh

if id -u "$user"; then
  echo "user exist: $user"
else
  if test -z "$user_uid"; then
    useradd --create-home --user-group "$user"
  else
    useradd --create-home --user-group --uid "$user_uid" "$user"
  fi
fi

if test ! -z "$user_password"; then
passwd "$user" <<EOT
$user_password
$user_password
EOT
fi

if test ! -z "$user_shell"; then
  usermod --shell "$user_shell" "$user"
fi