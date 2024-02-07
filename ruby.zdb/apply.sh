#!/bin/bash -ex

source params.sh

echo gem: --no-document > ~/.gemrc

# https://ruby-doc.org/stdlib-2.7.1/libdoc/irb/rdoc/IRB.html
# https://github.com/ruby/irb
echo "IRB.conf[:SAVE_HISTORY] = 1000" > ~/.irbrc

#gem install bundler
# The last version of bundler (>= 0) to support your Ruby & RubyGems was 2.3.27. Try installing it with `gem install bundler -v 2.3.27`

gem install bundler -v 2.3.27

#--verbose
#gem env
#set

# todo: install autocomplete

#which gem
#which bundler
#exit 202