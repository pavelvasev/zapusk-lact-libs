# memcached

Предназначение: чрута с установленным memcached

# Параметры
* **megabytes** - кол-во мегабайт под кеш
* **ip_port**=11211 - порт
* **ip_bind**=127.0.0.1 - интерфейс который слушать
* **extra_conf** - экстра-конфигурация (например -vv это запись лога запросов)
* **user**=root - пользователь (вариант безопаснее: nobody)

# Пример

```
########### my-memcached
[memcached]
ip_port=11212
ip_bind=127.0.0.1
megabytes=512
```
Результат: 
* на хосте появляется чрута и мемкеш внутри её с указанными парамерами.
* /etc/init.d/{{global_name}}-memcached скрипт управления чрутой
* /etc/logrotate.d/{{global_name}}-logrotate

# Тонкости
* генерируемый конфигур. файл логротейта настроен не перезапускать мемкеш

# Отслеживание работы memcached

## Командная строка
Просмотр статуса:
```
echo stats | nc 127.0.0.1 11211
echo stats items | nc 127.0.0.1 11211
echo stats sizes | nc 127.0.0.1 11211
echo stats slabs | nc 127.0.0.1 11211

telnet 127.0.0.1 11211
 stats
 quit
```
Слежение за динамикой в стиле утилиты top:
```
   watch "echo stats | nc 127.0.0.1 11211"
```

https://www.opennet.ru/tips/1855_statistic_monitoring_memcached.shtml

## Утилита

https://github.com/eculver/memcache-top

