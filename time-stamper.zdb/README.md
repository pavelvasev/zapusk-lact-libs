# time-stamper

Предназначение: приписывать к строчкам текстового файла временную метку.

1. Читает новые строчки текстового файла (tail -f)
2. Приписывает время (время,пробел,оригинальная-строка)
3. Пишет результат в новый файл

# Пример

```
########### my-program
[time-stamper]
infile=/var/log/memcache.log
outfile=/var/log/memcache.stamped.log
format=millisecond

```
Результат: появится файл memcache.stamped.log в котором будут строчки из memсache.log и время их появления.

# Параметры

* **infile** - входной файл
* **outfile** - выходной файл
* **format** - формат времени. Примеры: float_second, millisecond, microsecond. Полный перечень. https://www.rubydoc.info/stdlib/core/Process:clock_gettime

# Примечание

* Для работы создает init-d скрипт, т.о. отслеживание происходит со старта системы.
