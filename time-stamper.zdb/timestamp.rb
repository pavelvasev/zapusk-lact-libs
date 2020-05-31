#!/usr/bin/env ruby

# TIMESTAMPING UTILITY
# adds timestamp to every line of incoming stdin

# EXAMPLE
# add -vv to memcache.conf
# tail -f memcached.log |ruby rba.rb

# puts "stampler started"

format = (ENV["TIME_STAMP_FORMAT"] || "float_second").to_sym
while line=gets do
  # https://www.rubydoc.info/stdlib/core/Process:clock_gettime
  # r0 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
  # r0 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_second)
  # r0 = Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
  r0 = Process.clock_gettime(Process::CLOCK_MONOTONIC, format)
  
  #print Time.now.to_f, " ", line
  print r0, " ", line
  STDOUT.flush
end