#!/bin/bash -ex

source params.sh

echo gem: --no-document > ~/.gemrc
/usr/bin/gem install bundler

# todo: install autocomplete
