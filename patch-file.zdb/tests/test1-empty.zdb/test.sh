#!/bin/bash -ex

echo "" > a

zapusk apply

grep "alfa" a

zapusk destroy

if test grep alfa a; then exit 1; fi

echo test ok
