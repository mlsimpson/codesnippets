#!/usr/bin/env sh

if [ $# -ne  "2" ]
then
  echo "Invalid number of arguments"
  echo "Usage:  filehere.sh <filename> <path>\n"
  exit 1;
else
  if [ ! -e "$2/$1" ]
  then
    echo "$1 not present in $2"
  fi
fi
