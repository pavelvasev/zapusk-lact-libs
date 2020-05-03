#!/bin/bash -e

source params.sh

if test ! -z "$user_uid"; then
  echo user have specific uid -- will lock it
  passwd --lock $user
else
  echo leaved user - for some case.
fi
