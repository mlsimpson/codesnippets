#!/bin/zsh

wget http://archive.wrek.org/main/128kb/Wed1900.mp3
wget http://archive.wrek.org/main/128kb/Wed1930.mp3
wget http://archive.wrek.org/main/128kb/Wed2000.mp3
wget http://archive.wrek.org/main/128kb/Wed2030.mp3

sox Wed1900.mp3 Wed1930.mp3 Wed2000.mp3 Wed2030.mp3 ~/Mobius-`date --date="last wednesday" +"%m-%d-%Y"`.mp3

rm Wed*.mp3
