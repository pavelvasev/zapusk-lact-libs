#!/bin/bash -ex

# https://stackoverflow.com/questions/4060212/how-to-run-a-shell-script-when-a-file-or-directory-changes
# https://linux.die.net/man/1/inotifywait

source params.sh

if test -z "$dir"; then
  echo "dir var is blank" 
  exit 1
fi

if test -z "$runcmd"; then
  echo "runcmd var is blank"
  exit 2
fi

echo "starting inotify loop on dir=$dir"
echo "then gonna run cmd=$runcmd with dir as 1st arg"

while inotifywait --recursive --event create,move,delete $dir; do
  sleep 1
  $runcmd "$dir"
done