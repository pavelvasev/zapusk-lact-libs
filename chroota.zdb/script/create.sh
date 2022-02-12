#!/bin/bash -e
# Создает локальную чруту с заданным именем

source params.sh

# chroot_tool=chroot-tool.sh
# chroot_dir=.

if test -z "$chroot_dir"; then
  echo "chroot_dir var is blank!"
  exit 1
fi

if test -d "$chroot_dir/run"
then
#  echo "chroot directory already exist, seems no need to create, exiting. "
  exit 0
fi

if test -z "$debian_version"; then
  echo "debian_version var is blank!"
  exit 1
fi

# feature: use chroota_base_dir to create templates so we will use
# same file system for chrootas as for their templates, which is good:
# * maybe /tmp have no space
# * faster copy?
# * possible hardlinks? (maybe not possible between different fs?)
if test -z "$chroota_base_dir"; then
  echo "chroota_base_dir var is blank!"
  exit 1
fi

if test -z "$time_zone"; then
  echo "time_zone var is blank!"
  exit 1
fi

#chroot_template_dir=chroot-template
chroot_template_dir="$chroota_base_dir/chroot-template-$debian_version"

echo "Using chroot_template_dir=$chroot_template_dir. The specified debian version is used because it is configured by you in 'debian_version' parameter".

if ! test -d "$chroot_template_dir"
then
  CHROOT_TOOL_DEBOOTSTRAP_OPTIONS="$debootstrap_options" CHROOT_TOOL_DEBIAN_VERSION="$debian_version" CHROOT_TOOL_TIME_ZONE="$time_zone" $chroot_tool create -d "$chroot_template_dir"
fi

if ! test -d "$chroot_template_dir/run"
then
  echo "chroot template directory seems broken! please manually check it's content! dir=$chroot_template_dir"
  exit 1
fi

echo "Copying chroota template to $chroot_dir"

#mkdir -p ./chroots
# надо флажОк -T выставить чтобы в текущую директорию копировал
# и вторая проверка - если папка уже существет.. (мало ли мы ее создали по доброте душевной)
if test "$chroot_dir" == "." || test -d "$chroot_dir" 
then
  su -c "cp --recursive -T "$chroot_template_dir" "$chroot_dir" && chown -R $USER:$USER "$chroot_dir"" || echo Failed to copy $chroot_template_dir!
else
  su -c "cp --recursive "$chroot_template_dir" "$chroot_dir" && chown -R $USER:$USER "$chroot_dir"" || echo Failed to copy $chroot_template_dir!
fi

echo "Finished. All ok"