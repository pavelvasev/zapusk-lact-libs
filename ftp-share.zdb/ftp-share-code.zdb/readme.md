Алгоритм
1 создать юзера на хосте
2 запомнить его айди
3 в чруте на фазе update создать пользователя с таким же именем, таким же айди, и указанным паролем
4 прибиндить его домашнюю папку в чруте к указанной папке на хосте

----
возможно, лучше - host-ftp прибиндить к папке /data/ftp на хосте, а все шары юзеровские на нее уже
но для этого мне надо чтобы был тогда здб-тип mount bind и чтобы он срабатывал при запуске компьютера

ну и возникает вопрос а можно ли это сделать вообще. потому что прибиндить мы можем, но чтобы при запуске
системы.. - это надо ссылку в init.d прописывать. а мне лениво. плюс надо как-то вовремя этос делать,
до запуска остальных систем. короче надо с Мишей обсдуить.
пока же попросим чруту.

------
некие хитрости чтобы vsftpd стал признавать пользователя
1 выставлен shell напр /bin/dash
2 пользователь не в группе ftp
3 мб еще есть дом папка

# https://www.ryadel.com/en/vsftpd-configure-different-home-folder-each-user-specific-directory/
