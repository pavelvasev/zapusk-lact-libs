#!/bin/bash

source params.sh

if test -z "$TESTING_CHANNEL"; then
  TESTING_CHANNEL=1
fi

echo "(TESTING"
echo "
- code: $code
  comment: $comment" >&$TESTING_CHANNEL

#Q=$( set -o posix ; set )
Q=$(compgen -v)
#echo env=$Q

for name in $Q
do
#  echo checking name=$name
  if test "${name:0:4}" = "arg_"; then
#    echo "NAMEE FOUND $name"
    #value=$(eval "$name")
    value=${!name}
    name_s=${name:4}
    line_count=$(echo $value|wc -l) # что-то мне не удалось посчитать кол-во строк..
    echo $value
    echo linecount=$line_count
    if test $line_count -eq 1; then
      echo "  $name_s: $value" >&$TESTING_CHANNEL
    else
      echo "  $name_s: |"
      echo $value | while read i; do printf "%2s\n" "$i"; done
    fi
    # https://superuser.com/questions/621713/how-to-pad-strings-with-spaces-in-a-unix-shell-script
  fi
done

echo "TESTING)"
