#!/usr/bin/guile
!#

(define (systemctl . cmd) (zero? (status:exit-val (apply system* "systemctl" cmd))))

(define (write-script . lines)
  (lambda ()
    (for-each (lambda (l) (display l) (newline)) lines)))

(define (remove-daily-cron)
  (system "rm /etc/cron.daily/logrotate-zapusk")
)

(or (and 
	 (systemctl "enable" "logrotate.service")
	 (systemctl "enable" "logrotate.timer")
	 (systemctl "start" "logrotate.timer")
	 (remove-daily-cron)
	 (format #t "DONE~%"))
    (format #t "FAILURE~%"))
