#!/bin/bash -e

## . params.sh

if test -d bindings.params
then
  for f in bindings.params/*.sh
  do
    test -f "$f" && . "$f"
  done
fi

## BINDINGS_ZAPUSK="src:{{zapusk_tool_dir}} tgt:/zapusk-tool"
