#!/bin/bash -e

source params.sh

source /etc/os-release

if [ "$ID_LIKE" == "arch" ]; then
  list=${$pacman:-$list}
  echo installing packages $list
  pacman -S --noconfirm $list;
else

  specific_aptlist=apt_$VERSION_CODENAME
  specific_apt_vals=${!specific_aptlist}
  list=${specific_apt_vals:-$list}
  list=${list:-$apt}
  echo installing packages $list

  DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confold" install $list || exit 1
fi