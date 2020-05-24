# nginx-confd

Предназначение: вписывать confd-конфигурационные файлы в nginx с их предварительной проверкой.

## Параметры
* **content** -- содержимое файла
* **path** -- путь к файлу. По умолчанию равен `/etc/nginx/conf.d/{{global_name}}.conf`

## Пример
```
################# la-nginx-conf-d
[nginx-confd]
content="
proxy_cache_path /var/resizer_output_cache levels=1:2 keys_zone=resizer_output_cache:500m max_size=10g inactive=12h;
"
```
Результат: появление конфигурационного файла /etc/nginx/conf.d/la-nginx-conf-d`, 
выполнение проверок, перезагрузка (reload) nginx.

# См. также
* [nginx-conf](../nginx-conf.zdb)