# https-cert-item

Предназначение: программа для host-certbot, влекущая запрос сертификата для домена.

## Размещение на хосте

Предлагается размещать записи https-cert-item на хосте в каталоге **/data/https-proxy/auto-cert-requests.zdb**
Этот каталог автоматически загружается и выполняется как zdb-программа изнутри чруты host-certbot.

## Пример
Пусть есть набор файлов `*.ini` в каталоге **/data/https-proxy/auto-cert-requests.zdb** с содержимым вида
```
############### get-https-for-my-domain
[https-cert-item]
domains=some.ru www.some.ru m.some.ru special.some.ru
email=some@email
```
Тогда запуск команды **/etc/init.d/host-certbot request-certs** повлечет запрос для всех размещенных в каталоге сертификатов.

Примечание. Рассматривается вариант поставить inotify на указанную папку.

## Реализация
Команды:
* request-certs - запрос к certbot с указанными доменами
* request-certs-force - запрос к certbot без кеширования на уровне zapusk

Команды специально отличаются от apply, update, чтобы не смешивать установку ПО и запросы на сертификаты.
Лишь https-cert-request сделан так, чтобы и на стадии apply проводить запрос сертификатов.

## См также
Все программы семейства:
* [host-certbot](../host-certbot.zdb)
* [https-proxy](../https-proxy.zdb)
* [https-cert-request](../https-cert-request.zdb)