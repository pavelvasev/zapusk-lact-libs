#!/bin/bash -ex

echo alfa >a
echo beta >>a
echo gamma >>a

zapusk apply

grep "alfa" a
if grep "# test2-existing-block-1" a; then exit 1; fi

exit

zapusk destroy
grep "alfa" a
grep -v "# test2-existing-block-1" a

echo test ok
