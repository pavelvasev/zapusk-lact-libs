#!/bin/bash -e

source params.sh

if test -z "$arg_files"; then
  exit 0
fi

test ! -z "$tgtdir"
test ! -z "$cmd"

runbox=xbackup-arguments.zdb
mkdir -p $runbox
echo "state_dir=_state" >$runbox/zapusk.conf
cat $arg_files >$runbox/50-body.ini
echo "############# main" >$runbox/00-main.ini
# приделали шапочку ++ приписали параметр наш
# это такой все деревеньщиной пахнет.. блин.. сделал себе программку...
echo "tgtdir=$tgtdir" >$runbox/99-suffix.ini

# запускаем
$zapusk_tool $cmd --zdb $runbox

# в будущем, когда запуск научится читать стдин, можно будет сделать так:
#echo "####### main"; cat args_*.ini; | $zapusk_tool $cmd --zdb -- --state _box.state
