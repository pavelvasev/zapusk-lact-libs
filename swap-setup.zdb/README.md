# swap-setup

Создает swap-файл, подключает его к системе.

## Параметры

* *size_mb* - кол-во мегабайт
* *path* - путь к файлу

## Пример
```
###### make-swap-step
[swap-setup]
size_mb=4096
path=/var/swapfile
```

Результат: будет создан swap-файл и активирован, и добавлен в fstab.

## См. также

* https://wiki.debian.org/Swap
* https://devconnected.com/how-to-add-swap-space-on-debian-10-buster/
* https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-debian-10


