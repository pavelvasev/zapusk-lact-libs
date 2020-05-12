#!/usr/bin/ruby

=begin
 purpose: generate a /etc/init.d/name script to start/stop the specified command
          FOR ruby PUMA server

 name = ARGV[0]   # a system-wide name
 appdir = ARGV[1] # directory to cd into
 runcmd = ARGV[2] # command to run

 nuance:
 * all stdout and stderr will be written to /var/log/name.log
 * update-rc is not called
 
 * restart performed by usr2
 * RACK_ENV=production is added to runcmd
=end

txt = <<EOT
#!/bin/sh
### BEGIN INIT INFO
# Provides:          <NAME>
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       <DESCRIPTION>
### END INIT INFO

SCRIPT="<COMMAND>"
RUNAS=<USERNAME>

PIDFILE=/var/run/<NAME>.pid
#LOGFILE=/chroot.d/log/<NAME>.log
#mkdir -p /chroot.d/log
LOGFILE=<LOGFILE>

start() {
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
    echo 'Service already running' >&2
    return 0
  fi
  echo 'Starting service…' >&2
#  su -c "$SCRIPT >> $LOGFILE 2>&1" $RUNAS & echo $! > $PIDFILE
  sh -c "$SCRIPT >> $LOGFILE 2>&1 & echo \\$! > $PIDFILE"
  # todo более что-то умное
  sleep 0.01
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
    echo 'Service started' >&2
    return 0
  else
    echo 'Service start failure - pid is not visible!' >&2
    return 2
  fi
}

stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    return 0
  fi
  echo 'Stopping service…' >&2
  kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
  echo 'Service stopped' >&2
}

restart() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    start
    return 0
  fi
#  "phased" (soft) restart not working (((
#  echo 'Sending USR1 to service…' >&2
#  kill -10 $(cat "$PIDFILE")
  echo 'Sending USR2 to service…' >&2
  kill -12 $(cat "$PIDFILE")
  echo 'signal sent. service should restart' >&2
  return 0
}

uninstall() {
  echo -n "Are you really sure you want to uninstall this service? That cannot be undone. [yes|No] "
  local SURE
  read SURE
  if [ "$SURE" = "yes" ]; then
    stop
    rm -f "$PIDFILE"
    echo "Notice: log file is not be removed: '$LOGFILE'" >&2
    update-rc.d -f <NAME> remove
    rm -fv "$0"
  fi
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  uninstall)
    uninstall
    ;;
  restart)
    restart || start
    #stop
    #start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|uninstall}"
esac
EOT

name = ARGV[0]
appdir = ARGV[1]
rubyfile = ARGV[2]

cmd="cd #{appdir} && RACK_ENV=production #{rubyfile}"

txt = txt.gsub("<NAME>",name).gsub("<USERNAME>","root").gsub("<COMMAND>",cmd)
         .gsub("<LOGFILE>",ENV["INITD_LOGFILE"]||"/var/log/#{name}.log")

out="/etc/init.d/#{name}"
puts "writing code to file #{out}"
File.open(out,"w") do |f|
  f.puts txt
end

puts "making file executable"
puts `chmod +x /etc/init.d/#{name}`

puts "done"