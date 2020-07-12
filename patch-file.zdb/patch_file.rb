#!/usr/bin/env ruby

# вставляет входные строки в текстовый файл,
# отмечая их меткой # global_name
# если там уже были строки с такой меткой - заменяет их.
# отметка ставится после строки справа

usage="usage: patch_file filename metka <content"

file = ARGV[0] || raise(usage)
metka = ARGV[1] || raise(usage)
orig = File.readlines( file ).map{ |line| line.chomp }
r = Regexp.new("^(.+) # #{metka}$")
rejected = []
file_content = orig.reject{ |line| 
  if line =~ r
    rejected.push $1
    true
  else
    false
  end
}

content = STDIN.readlines.map{ |line| line.chomp }

if content.join == rejected.join
  puts "content already deployed in file #{file}"
  exit 0
end

if content.length == 0
  puts "content is empty"
  exit 0
end

# у нас есть
# file_content - текущий контент файла
# content - чего в него добавить

to_add = content.map{ |line| "#{line} # #{metka}" }

File.open( hosts_file,"w") do |f|
  f.puts (file_content + to_add).join("\n")
end

puts "file patched"
#puts "file #{file} patched with content:"
#puts to_add.join("\n")
