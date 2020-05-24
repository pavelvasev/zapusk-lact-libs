# https-cert-request

Предназначение: сделать так, чтобы на хосте в папке **/data/https-proxy/auto-certs** появился 
сертификат для запрошенного домена (доменов). 

При этом считается, что на хосте развернут какой-нибудь https-сервер, например [https-proxy](../https-proxy.zdb).

## Пример
```
########## https-cert-for-system #######
[https-cert-request]
domains=some.ru www.some.ru m.some.ru special.some.ru
email=some@email
```
Результат: на хосте развернут host-certbot, запрошен сертификат, который будет (раз в 3 месяца) обновляться.

## Устройство
1. Ставит [host-certbot](../host-certbot)
2. Внедряет в него [https-cert-item](../https-cert-item)
