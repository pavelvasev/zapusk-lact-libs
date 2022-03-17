# Назначение
Устанавливает пакеты операционной системы

# Примеры

```
############ install_things
[os-package]
pacman=mc git alfa
apt=mc git alfa2
apt_wheezy=mc git alfa1
```
В архлинукс будет вызван пакман с установкой пакетов mc git и alfa.
В дебианах будет вызван apt с установкой mc git alfa2.
При этом в дебиан визи будет вызван apt с установкой mc git alfa1.

```
[os-package]
list=mc git ruby
```
Во всех ос будет вызвана установка пакетов mc git и ruby.


# Приоритет переменных:
В архлинукс
1. pacman
2. list

В дебиан
1. apt_(debian-version)
2. apt
3. list


# Изменения
17.03.2022
apt заменен на apt-get потому что apt не везде есть плюс пишут что у apt еще нестабильный апи https://itsfoss.com/apt-vs-apt-get-difference