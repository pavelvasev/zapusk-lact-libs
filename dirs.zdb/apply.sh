#!/bin/bash -e

source params.sh

# no " => indidivual items
# care - * and ? things will be expanded here..
for i in $list; do
  mkdir -p "$i"
done