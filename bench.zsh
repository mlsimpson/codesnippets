#!/bin/zsh

export TIMEFMT='%E'

main() {
  echo "Purging the disk cache..."
  unamestr=`uname`
  if [[ "$unamestr" == 'Linux' ]]; then
    sync; sudo sysctl vm/drop_caches=3; sync; sudo sysctl vm/drop_caches=0; sync
  elif [[ "$unamestr" == 'Darwin' ]]; then
    purge
  fi

  # time's output is on stderr.
  zsh_elapsed_time=$( (time zsh -ilc exit) 2>&1 )
  echo "zsh:\t$zsh_elapsed_time"

  # As above, and also vim wants its stdout to be the terminal.
  if [[ "$unamestr" == 'Linux' ]]; then
    vim_elapsed_time=$( (time vim +q) 2>&1 >$(tty) )
  elif [[ "$unamestr" == 'Darwin' ]]; then
    vim_elapsed_time=$( (time /Applications/MacVim.app/Contents/MacOS/Vim +q) 2>&1 >$(tty) )
  fi
  echo "vim:\t$vim_elapsed_time"
}

main
