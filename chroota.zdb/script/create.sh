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

#chroot_template_dir=chroot-template
chroot_template_dir="/tmp/chroot-template-$debian_version"

if ! test -d "$chroot_template_dir"
then
  CHROOT_TOOL_DEBIAN_VERSION="$debian_version" $chroot_tool create -d "$chroot_template_dir"
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