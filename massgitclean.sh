#!/usr/local/bin/zsh
for i in $(find . -type d)
do
  grealpath $i >> ./dirpath
done

for d in `grep -v ".git" ./dirpath`
do
  cd $d
  /Users/threv/code/snippets/gitclean.sh
done

rm ./dirpath
