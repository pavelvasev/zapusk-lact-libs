# zapusk-lact-libs

Набор [Zapusk](https://github.com/pavelvasev/zapusk)-программ Конструктора сайтов ЛайнАкт.

# Установка

Для использования набора его необходимо разместить в каталоге
 [zapusk-tool](https://github.com/pavelvasev/zapusk-tool)/lib/zapusk-lact-libs.
 
```
cd zapusk-tool/lib
git clone https://github.com/pavelvasev/zapusk-lact-libs.git
```

> Мотивация - zapusk-tool bind-ится целиком со своим lib внутрь виртуальных машин, 
если таковые появляются по ходу работы.

# Состав

## chroot
Создание виртуальных машин на базе chroot-tool

* [chroota](chroota.zdb) - с помощью chroot-tool/debootstrap создает виртуальную машину debian stretch
* [chroota-goods](chroota-goods.zdb) - полезные коды для инициализации chroot-машин после создания (apt update и т.д.)
* [chroota-logrotate](chroota-logrotate.zdb) - настройка logrotate для чруты
* [chroota-user](chroota-user.zdb) - создание пользователя на хосте и в чруте с одинаковым id
* [employ](employ.zdb) - встраивает произвольные zdb-коды в чруты подобные им

## system
Действия в ОС

 * [dirs](dirs.zdb) создание каталогов
 * [chmod](chmod.zdb) настройка прав доступа
 * [chown](chown.zdb) смена владельца
 * [inotify-dir](inotify-dir.zdb) мониторинг изменения каталога
 
 * [create-user](create-user.zdb) создание пользователя
 * [ssh-authorize-key](ssh-authorize-key.zdb) добавление записи в .ssh/authorized_keys
 
 * [cron](cron.zdb) создание cron-задания
 * [logrotate](logrotate.zdb) создание logrotate-задания
 * [generate-initd](generate-initd.zdb) создание init-d скрипта
 * [generate-initd-puma](generate-initd-puma.zdb) создание init-d скрипта для puma (особый сигнал restart) 
 
 * [apt](apt.zdb) установка пакета
 * [apt-get-cmd](apt-get-cmd.zdb) вызов apt-get с произвольной командой
 * [stretch-backports](stretch-backports.zdb) установка stretch-backports в sources.list

## https
Работа с https
 * [https-proxy](https-proxy.zdb) https endpoint, проксирующий входящие https-запросы на localhost
 * [host-certbot](https-proxy.zdb) certbot в chroot, запрашивает и обновляет сертификаты в letsencrypt
 * [https-cert-item](https-cert-item.zdb) программа для host-certbot, влекущая запрос сертификата для домена
 * [https-cert-request](https-cert-request.zdb) высокоуровневая команда, устанавливающая host-certbot 
 и внедряющая в него запрос на сертификат https-cert-item.

## nginx
Настройка nginx

 * [nginx](nginx.zdb) установка nginx из репозитория
 * [nginx-setup](nginx-setup.zdb) внедрение скомпилированного nginx в систему (создание init-d скрипта и других настроек)
 * [nginx-cache](nginx-cache.zdb) кеширование бекенда с помощью nginx.
 * [nginx-conf](nginx-conf.zdb) внедрение конфигурационного файла в nginx с предварительной проверкой
 * [nginx-confd](nginx-confd.zdb) внедрение confd-файла в nginx с предварительной проверкой
 * [nginx-location](nginx-location.zdb) внедрение snippet-файла с location в nginx с предварительной проверкой

## nodejs

 * [nodejs](nodejs.zdb) установка nodejs
 * [npm-global](npm-global.zdb) установка пакетов npm с флагом global
 * [nodejs-app](nodejs-app.zdb) установка заданного nodejs-приложения

## services
 * [memcached](memcached.zdb) мемкеш в чруте
 * [host-ftp](host-ftp.zdb) vsftpd в чруте
 * [ftp-sjare](ftp-share.zdb) создание ftp-доступа к заданной директории

## xbackup
 * [xbackup](xbackup.zdb) инкрементальный rsync
 * [xclean](xclean.zdb) удаление лишних каталогов
 * [xif](xif.zdb) условное выполнение

## other
 * [ruby](ruby.zdb) установка и настройка ruby из пакетов
 * [gems](gems.zdb) устанавливает gem по списку
 * [git](git.zdb) загрузка указанного репозитория
 * [time-stamper](time-stamper.zdb) приписывает метки времени всем строкам файла
 
# Copyright
2020 Павел Васёв, ЛайнАкт

MIT license