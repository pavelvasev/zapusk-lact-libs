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

# Примечания
* если файла authorized_keys нет, то он создается с chown указанным пользователем и правами 600.
* если у файла странные права и т.п. - программа это не проверяет.
* если user меняется, то установленный ранее ключ у старого пользователя - удаляется.