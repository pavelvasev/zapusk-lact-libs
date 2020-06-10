# ssh-authorize-key

Предназначение: устанавливает публичную часть ключа в authorized_keys

# Пример

```
########### my
[ssh-authorize-key]
user=ivan
content=ecdsa-sha2-nistp521 AAAA....7eavho7Q== something
```
Результат: в домашнем каталоге ivan в файл .ssh/authorized_keys добавится строчка content

# Команды

* **apply** - добавляет ключ
* **destroy** - убирает ключ

# Параметры

* **user** - пользователь которому добавить. По умолчанию root.
* **content** - содержимое ключа. Указывается публичная часть (одностроковая)
* **title** - название ключа для красоты
