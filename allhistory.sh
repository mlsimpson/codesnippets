#!/bin/sh
# Script to accumulate unique .zsh_history entries in ~/.allhistory
(cat $HOME/.zsh_history | sed -e 's/[^;]*;//' && cat $HOME/.allhistory) | sort | uniq >   $HOME/.allhistory.new
rm $HOME/.allhistory
mv $HOME/.allhistory.new $HOME/.allhistory
