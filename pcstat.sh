while [ 1 ]
do
  ps auxr | awk '{ print "\033[1;31m"$2"\033[0m\t""\033[1;32m"$3"%\033[0m\t"; for (i=11; i<=NF; i++) printf("%s%s", $i, (i==NF) ? "\n" : OFS) }' | awk '{ if ( ( NR % 2 ) == 0 ) { printf("%s\n",$0) } else { printf("%s ",$0) } }' | awk '{ print ( (NR==1) ? "\033[1;34mPID\tLOAD\t COMMAND" : $0 ) }'i | head $LINES
  sleep 1
  clear
done
