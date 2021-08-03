#!/bin/bash -e

# https://stackoverflow.com/questions/4060212/how-to-run-a-shell-script-when-a-file-or-directory-changes
# https://linux.die.net/man/1/inotifywait

echo "==================== inotify-dir-zdb-script started ========================"
date

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
echo "then gonna run cmd=$runcmd"

while inotifywait --recursive --event create,move,delete,modify $dir; do
  echo "sleeping for 1 second"
  sleep 1
  echo "ok passing to runcmd: $runcmd"
  INOTIFY_DETECTED_DIR="$dir" $runcmd || echo "Script exec failed. However, we continue (else inotify will stop)"
done
