# nginx-conf

Предназначение: вписывать конфигурационные файлы в nginx с их предварительной проверкой.

## Параметры
* **content** -- содержимое файла
* **path** -- путь к файлу. По умолчанию равен `/etc/nginx/sites-enabled/{{global_name}}`

## Пример
```
################# das-nginx-conf
[nginx-conf]
path=/etc/nginx/snippets/location-of-me.conf
content="
location = /hello {
  return 222;
}
"
```
Результат: появление указанного конфигурационного файла в nginx, выполнение проверок, перезагрузка (reload) nginx.

## Пример
```
################# das-nginx-server
[nginx-conf]
content="
server {
   server_name  {{domains}};
   listen       80;
   root         {{dir}};
   index        index.html index.htm;
}
"
```
Результат: появление файла `/etc/nginx/sites-enabled/das-nginx-server` с указанным содержимым, 
выполнение проверок, перезагрузка (reload) nginx.
При этом в содержимое будет выполнена подстановка значений domains и dir.

## Связи
* nginx - вызывается для проверки файлов конфигурации
* /etc/init.d/nginx - вызывается команда reload

## Алгоритм

1. Проверить что текущая конфигурация nginx рабочая (nginx -t).
   Если да - продолжить. Если нет - ошибка.
2. Вписать предлагаемый новый файл
3. Проверить что полученная обновленная конфиграция nginx - рабочая
   Если да - продолжить. Если нет - стереть файл и ошибка.
4. Создать отложенное задание перезапуска `nginx-reload=/etc/init.d/nginx reload`

# См. также
* [nginx-confd](../nginx-confd.zdb)
* [nginx-location](../nginx-location.zdb)
