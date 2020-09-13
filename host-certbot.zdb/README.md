# host-certbot

Предназначение: запрашивает и обновляет https-сертификаты в letsencypt, является чрутой для certbot.

## Подготовка
Всякий nginx-вебсайт, желающий уметь работать по https, должен заранее подключить следующий сниппет, который генерируется host-certbot:
```
include /etc/nginx/snippets/location-https-cert-*;
```

## Запросы на сертификаты

Чтобы host-certbot выполнял запросы на сертификаты, в каталоге **/data/https-proxy/auto-certs-requests.zdb**
следует формировать zdb-программу из записей вида:
```
###################### cert-request-for-some-domain
[https-cert-item]
email={{email}}
domains={{domains}}
```
* **domains** список доменов для сертификата
* **email** емейл ответсвенного лица

Это влечет автоматическое выполнение внутри host-certbot чруты zdb-программ типа [https-cert-item](../https-cert-item.zdb),
что влечет certbot-запросы на сертификаты. Автоматика идет через отслеживание новых файлов по inotify.

## Запросы из zdb-программ

Дополнительно, на машине можно пользоваться [https-cert-request](../https-cert-request.zdb)

## Реализация

1. Разворачивается certbot
2. Регистрируется в cron с командой renew-certs
3. Выставляет inotify на папку **/data/https-proxy/auto-certs-requests.zdb** и при изменении вызывает request-certs

Реагирует на команды:
* request-certs - запросить сертификаты
* renew-certs - обновить запрошенные ранее сертификаты
* deploy-certs - скопировать все запрошенные сертификаты в каталог  **/data/https-proxy/auto-certs** на хосте.

## https-обслуживание

Host-certbot только запрашивает сертификаты. Https-сервер это кто-то другой, например [https-proxy.zdb](../https-proxy.zdb)
