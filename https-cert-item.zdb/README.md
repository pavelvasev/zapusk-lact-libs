# https-cert-item

Предназначение: программа для host-certbot, влекущая запрос сертификата для домена.

## Размещение на хосте

Предлагается размещать записи https-cert-item на хосте в каталоге **/data/https-proxy/auto-cert-requests.zdb**
Этот каталог автоматически загружается и выполняется как zdb-программа изнутри чруты host-certbot.

## Пример
Пусть есть набор файлов `*.ini` в каталоге **/data/https-proxy/auto-cert-requests.zdb**
```
############### get-https-for-my-domain
[https-cert-item]
domains=some.ru www.some.ru m.some.ru special.some.ru
email=some@email
```
Тогда запуск команды **/etc/init.d/host-certbot update** повлечет запрос всех размещенных в каталоге сертификатов.
* Также можно вызывать тип host-certbot с командой update
* Также можно вызвать не update а request-certs - это более принудительный запрос.

Примечание. Рассматриваетя вариант поставить inotify на указанную папку.

## См также
Все программы семейства:
* (host-certbot)[../host-certbot.zdb]
* (https-proxy)[../https-proxy.zdb]
* (https-cert-request)[../https-cert-request.zdb]