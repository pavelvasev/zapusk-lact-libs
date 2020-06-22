# xbackup

Предназначение: вызывает [xbackup-tool](https://github.com/pavelvasev/xbackup-tool) для проверения rsync-бэкапа.

# Пример

```
########### my-program
[xbackup]
config_files={{zdb_dir}}/my-*.csv
```
Результат: запускается xbackup-tool my-*.csv

# Команды

* **apply** - вызов xbackup-tool для проведения бэкапа

# Параметры

* **config_files** - путь к файлам конфигурации бэкапа.
