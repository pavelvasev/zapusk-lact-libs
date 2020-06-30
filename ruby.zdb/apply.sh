#!/bin/bash -ex

source params.sh

echo gem: --no-document > ~/.gemrc

# https://ruby-doc.org/stdlib-2.7.1/libdoc/irb/rdoc/IRB.html
# https://github.com/ruby/irb
echo "IRB.conf[:SAVE_HISTORY] = 1000" > ~/.irbrc

gem install bundler

#--verbose
#gem env
#set

# todo: install autocomplete

#which gem
#which bundler
#exit 202