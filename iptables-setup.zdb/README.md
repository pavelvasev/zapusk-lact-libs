# iptables-setup

Предназначение: установка правил iptables, загружаемых вместе с машиной

# Параметры
* *content* - список правил, многострочная строка

# Алгоритм
* Создает выполняемый файл /etc/network/if-pre-up.d/{{global_name}}, 
  в который записывает команду загрузки правил
  `iptables-restore <content`
  Когда стартует сетевой интерфейс, этот файл будет выполнен ос и т.о. правила загружены.
* Дополнительно, сразу выполняет этот файл.

# Дополнительно

[Документация по iptables](https://netfilter.org/documentation/HOWTO//packet-filtering-HOWTO-7.html#ss7.2)

# Пример
```
########### my-program
[iptables-setup]
content="
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [99:17703]

# ####################### 127.0.0.0.1
-A INPUT -i lo -j ACCEPT

# ######################## outgoing..
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ######################## http
-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT

# ######################## ssh
-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

# ####################### mysql только с указанного ip
-A INPUT -s 95.19.144.10/32 -p tcp -m tcp --dport 3306 -j ACCEPT

# ####################### others
-A INPUT -j DROP

# ####################### done
COMMIT

"

```
Результат: файрволл ос iptables работает согласно указанным правилам.


# Команды

* **apply** - применить правила к ос
* **destroy** - удалить правила из ос

