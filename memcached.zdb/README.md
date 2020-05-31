# memcached

Предназначение: чрута с установленным memcached

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



