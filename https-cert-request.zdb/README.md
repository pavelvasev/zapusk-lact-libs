# https-cert-request

Предназначение: сделать так, чтобы на хосте в папке **/data/https-proxy/auto-certs** появился 
сертификатдля запрошенного домена. 

При этом считается, что на хосте развернут какой-нибудь https-сервер, например [https-proxy](../https-proxy.zdb)

## Пример
```
########## https-cert-for-system #######
domains=some.ru www.some.ru m.some.ru special.some.ru
email=some@email
```

## Реализация
1. Ставит [host-certbot](../host-certbot)
2. Внедряет в него [https-cert-item](../https-cert-item)
