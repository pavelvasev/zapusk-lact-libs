Предназначение
==============
Программа, которая умеет внедрять в chroot-окружение заданные шаги.


Подробнее
=========
По сути, employ это функтор, который имея на входе набор zdb-шагов [A,E1,E2,..,En]:

1. Создает новую zdb-программу с телом A.
2. Посылает программе (1) команды employ и unmeploy, передавая на им вход элементы списка [Ei] поштучно.
3. Проксирует все внешние команды в программу (1).

Это позволяет формировать наполнение [чрут](../chroota.zdb) и в перспективе для других виртуальных машин.
Подробнее см. далее раздел Зачем.

Пример
======
```
################ block-5
[employ]

[chroota]
global_name=my1
alfa=15

[nodejs]
[nodejs-app]
apprepo=https://github.com/johnpapa/node-hello
```

`zapusk apply`:

1. Будет создана служебная программа с содержимым `[chroota]` (включая параметры global_name и alfa)
2. На ней будет вызвана команда employ с путем к временному файлу, содержащему узел `[nodejs]` (включая его параметры)
3. И аналогичное действие employ с путем к файлу с [nodejs-app]

Как результат, будет создана чрута и в ней развернут nodejs и развернуто и запущено nodejs-приложение.

Более того, все последующие поступающие команды будут передаваться в созданную чруту, и через неё nodejs-приложению,
`zapusk start`, `zapusk stop` и пт.

Примечание
==========
* В качестве первого аргумента employ годится не любой, а только поддерживающий команду employ и unemploy.
* Employ сам поддерживает команды employ и unemploy. Поэтому можно строить башенки из employ.

Внедрение из разных запуск-программ в одну виртуальную машину
=============================================================
Допустимо, если одна и та же фактическая чрута используется в разных employ-цепочках.
Является ли чрута одной и той же, определяет её global_name.

Чтобы не происходило удаление всего при удалении какого-либо employ-записи,
предлагается использовать секцию guard. См. например как сделан host-ftp и ftp-share.

Реализация
==========

Алгоритм внедрения:
1. На вход [employ] поступает набор шагов. Первый шаг A считается базовым, остальные - Е1,E1,..,En будут внедряться в него.
2. Создается каталог `box.zdb`, в нем создается файл с телом A.
3. Для каждого Ei, вызывается zapusk employ --zdb box.zdb --a "copath=файл-шага" --a "colevel=i".

Что делать с этими employ-командами -- это семантика A.

Шаг (3) реализуется с помощью создания вспомогательной программы `box.employ.zdb`
которая наполняется блоками типа [employ-item](../employ-item.zdb).

Получается, что изменение списка аргументов данного employ (удаление, появление) - отслеживаются самим zapusk-ом 
на уровне изменения блоков в box.employ.zdb.

Протокол
========
Каждый zdb-тип, который желает быть первым аргументом employ, должен поддерживать команды:

### employ
Внедрение указанного блока.

Параметры:
* **copath** - полный путь к файлу с описанием внедряемого блока (чтобы можно было его себе скопировать).
* **colevel** -- номер этого шага (чтобы можно было строить приоритеты).

В ответ на команду zdb-программа должна импортировать к себе блок, описанный в файле copath.
Идентифицировать (различать) блоки следует по параметру global_name в этом блоке.

### unemploy
Удаление указанного блока.

Параметры:
* **copath** - полный путь к файлу с удаляемого блока (чтобы можно было его себе скопировать).

Идентифицировать блок следует по global_name, идущем в нем.

Зачем
=====

Мотивация в том, что есть желание описывать содержимое чрут внешним образом. 

Когда-то давно каждая чрута имела свой репозиторий, хранящий все содержимое chroot.d. 
В случае zapusk показалось удобным, если мы:
1. Будем формировать в каталоге /chroot.d запуск программу.
2. Будем делать это внешним образом по отношению к чрутам.

Тогда все содержимое чруты (все программы в ней и т.п.) можно описывать на уровне zapusk, 
см. пример выше. Преимущества:
* Не нужны репозитории для каждой отдельной чруты.
* Вообще тело чруты можно довольно удобно программировать, находясь и управляя zapusk-ом на хосте.
* Можно "докидывать" в чруту разные новые zapusk-кусочки. Например через это сделан тип [ftp-share](../ftp-share.zdb)
который создает новых пользователей в ftp-чруте на каждую шару.

Это потребовало разработки Employ и также соответствуюего его протоколу типа [chroota](../chroota.zdb), что и было сделано.

Альтернативно
=============
Рассматривался вариант что чрута сама обрабатывает свои аргументы, и нам этом все.
* Но код чруты получался очень сложный. 
* Плюс была сложность с таким режимом использования, когда два экземпляра запуск-программ
вызывали в итоге одну запуск-программу, которая несла свой код в чруту. При удалении приходилось как-то понимать, что вот
это удалять можно, а вот это надо оставить. Employ логика это упрощала, делая модульным с помощью guard.(?)
* Приходилось писать явную вставку [args] с тем, чтобы пользователи данной чрут-запуск-программы могли добавлять что-то
в данную чруту. Employ-логика говорит что ей [args] в первом аргументе писать не надо - ей все-равно вызывать employ.

Поэтому было решено логику employ вынести в отдельный тип. Для упрощения и решения обозначенного.
Действительно, choota стала проще. Но зато появилось это некое мозгоклюйство для пользователя - что такое employ, как это объяснить?
 * Хотя быть может и не надо объяснять, а сказать что это оператор для встраивания кодов в чруту (чем он и является).
 * А возможно, стоит вернуть все в чруту с тем, чтобы она пользовалась employ-ем как сервисной функцией, но сама, 
незаметно для пользователя.

Особенности
===========
Первый шаг A разворачивается только 1 раз. Дальше даже при изменении параметров он не обновляется.
Так проще реализовать на текущий момент.

Заметки
=======
Сейчас сделано, что employ какой-нибудь глобальной чруты развернет ее. Теперь думаю, что этого не надо делать, не надо ее автоматически разворачивать.
Потому что у чруты могут быть какие-то свои параметры, а мы получается должны повторять их и в пользователях. Это неправильно.
Возможно стоит предусмотреть либо не [employ] а [employ-exising], либо ключ - по крайней мере для глобальных чрут типа host-certbot, ftp и так далее.