find . -type d | while read d; do
  cd "$d"
  c=1
  for i in *.vgm; do
    if [ ! -f "$i" ]; then
      continue
    fi
    r="${PWD##*/}$i"
    mv -i "$i" "$r"
    ((c++))
  done
  cd "$OLDPWD"
done
