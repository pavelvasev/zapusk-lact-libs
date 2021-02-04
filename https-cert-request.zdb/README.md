# https-cert-request

Предназначение: сделать так, чтобы на хосте в папке **/data/https-proxy/auto-certs** появился 
сертификат для запрошенного домена (доменов). 

При этом считается, что на хосте развернут какой-нибудь https-сервер, например [https-proxy](../https-proxy.zdb).

## Параметры
* domains - список доменов через пробел
* email - емейл на который выписать сертификат

## Пример
```
########## https-cert-for-system #######
[https-cert-request]
domains=some.ru www.some.ru m.some.ru special.some.ru
email=some@email
```
Результат `zapusk apply`: на хосте развернут host-certbot, запрошен сертификат, который будет затем обновляться раз в 3 месяца.

## Команды
* apply - подготовить host-certbot и запросить сертификат
* request-certs - запросить сертификат (host-certbot уже должен быть подготовлен)
* request-certs-force - запросить сертификат без учета кеширования

## Устройство
1. Ставит [host-certbot](../host-certbot.zdb)
2. Внедряет в него [https-cert-item](../https-cert-item.zdb)
