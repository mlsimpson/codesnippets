#!/usr/local/bin/zsh

# create a list of all existing gems
gem list --no-versions | sed -e '/^(*|$)/d' > installed_gems

# uninstall all existing gems
gem list | cut -d" " -f1 | xargs gem uninstall -aIx

# reinstalling latest gems
cat installed_gems | xargs sudo gem install

# delete installed_gems list
rm installed_gems
