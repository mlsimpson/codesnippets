#!/bin/zsh

export TIMEFMT='%E'

main() {
  echo "Purging the disk cache..."
  purge

  # time's output is on stderr.
  zsh_elapsed_time=$( (time zsh -ilc exit) 2>&1 )
  echo "zsh:\t$zsh_elapsed_time"

  # As above, and also vim wants its stdout to be the terminal.
  vim_elapsed_time=$( (time /Applications/MacVim.app/Contents/MacOS/Vim +q) 2>&1 >$(tty) )
  echo "vim:\t$vim_elapsed_time"
}

main
