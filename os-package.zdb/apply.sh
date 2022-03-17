#!/bin/bash -e

source params.sh

source /etc/os-release

if [ "$ID_LIKE" == "arch" ]; then
  list=${$pacman:-$list}
  echo "zapusk os-package: installing packages $list"
  pacman -S --noconfirm $list;
else

  specific_aptlist=apt_$VERSION_CODENAME
#echo 1 $specific_aptlist
  specific_apt_vals=${!specific_aptlist}
#echo 2 $specific_apt_vals
  list=${specific_apt_vals:-$list}
#echo 3 $list
  list=${list:-$apt}
  echo "zapusk os-package: installing packages $list"

  DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confold" install $list || exit 1
fi