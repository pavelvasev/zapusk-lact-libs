# sshd-disable-password

Предназначение: запретить ssh-серверу аутентификацию по паролю.

## Алгоритм

Перенастраивает файл `/etc/ssh/sshd_config`
добавляя в него строчку `PasswordAuthentication no`
и перезапускает ssh-сервер