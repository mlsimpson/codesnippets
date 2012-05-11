  ps auxm | awk '{ print "\033[1;31m"$2"\033[0m\t""\033[1;32m"$6/1024" MB\033[0m\t";
  for (i=11; i<=NF; i++) printf("%s%s", $i, (i==NF) ? "\n" : OFS) }' \
  | awk '{ if ( ( NR % 2 ) == 0 ) { printf("%s\n",$0) } else { printf("%s ",$0) } }' \
  | awk '{ print ( (NR==1) ? "\033[1;34mPID\tSIZE\t\t COMMAND" : $0 ) }' | less -mR
