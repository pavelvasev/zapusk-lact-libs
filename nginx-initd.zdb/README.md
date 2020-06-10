Предназначение: создает init-d скрипт для нжинкса

Это надо для нжинксов, скомпилированных вручную, бо они не ставятся в PATH и в init-d себя не пишут.

Примечание.
* нжикс считается лежит в /opt/nginx
* Делает это на основе https://gist.githubusercontent.com/nesquena/633514/raw/a62a3104f05a34e279bb276bde77663bf39e57c1/nginx
* Вот поновее версия если что https://github.com/JasonGiedymin/nginx-init-ubuntu
но в ней загрузка default, а это уже сайд-эффект для нас, поэтому пока пусть будет старая

См также
* https://github.com/AnsibleShipyard/ansible-nginx/blob/master/Dockerfile
* https://github.com/AnsibleShipyard/ansible-nginx

