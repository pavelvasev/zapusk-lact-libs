# nginx-cache

Предназначение: кеширование бекенда с помощью nginx.

1. Генерирует код location-а для nginx.
2. Location обращается к заданному бекенду.
3. Ответы с любым кодом кеширует встроенным механизмом nginx.
4. Повторные запросы отдает из кеша.

# Пример

```
########### nginx-cache
[nginx-cache]
location_path=my33
backend_url=http://127.0.0.1:1025

```
Результат: будут созданы файлы 
* /etc/nginx/conf.d/{{global_name}} -- конфигурация кеша
* /etc/nginx/snippets/location-{{global_name}} -- локейшн с включенным кешированием

Чтобы это использовать, следует в каком-либо nginx-сервере прописать использование этого location:
```
server {
  server_name myserver;
  ...
  include snippets/location-{{имя}};
  ...
}
```
После чего локейшн `http://server_name/{{location_path}}/...` будет вести себя, как описано выше.

# Связи

  * nginx
  * конфигурационные файлы nginx
  * какое-либо http-приложение, доступное по backend_url
