#!/bin/bash -e

# Incremental rsync backup

# usage: src=rsync-source-url tgtdir=local-dir rsync-x-backup.sh

# result:
# * rsync data from $src to $tgtdir/current-date-stamp-dir/
# * have $tgtdir/latest symlink to last successful backup dir above
# * use hard links for files that are not changed from previous sync.

# p.s. use with flock:
# flock --nonblock local-dir/lock -c "src=rsync-source-url tgtdir=local-dir rsync-x-backup.sh"

# 2020 (c) Pavel Vasev

test ! -z "$tgtdir"
test ! -z "$src"

mkdir -p $tgtdir

processdir="$tgtdir/process"
latestdir="$tgtdir/latest"
datedir="$tgtdir/$(date +\%Y-\%m-\%d-\%H-\%M)"
 # почему-то рсинх-у грустно если этих каталогов нет
mkdir -p $processdir

if test -d "$datedir"; then
  echo "dir $datedir already exist! skipping backup."
  exit 0
fi

(
flock --verbose --nonblock 9 || (echo lockfile is locked; skipping backup operation; exit 0)

rsync -rt --copy-links -v --delete --stats --bwlimit=1000 "$src/" "$processdir" --link-dest="$latestdir" $rsync_options
 # --copy-links это про символические ссылки в исходнике
 # --link-dest это про то где искать оригиналы файлов, скачанных ранее

mv --no-target-directory "$processdir" "$datedir"
rm -f -d "$latestdir"
ln --relative -s "$datedir" "$latestdir"
) 9>"$processdir/lockfile"