#!/bin/sh

autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6669:irc.choopa.net:6669 threv@users.freeshells.org
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6666:chat.freenode.net:6666 threv@users.freeshells.org
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6697:ircs.cmgdigital.com:6697 threv@users.freeshells.org
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6667:im.bitlbee.org:6667 threv@users.freeshells.org
ssh -D 8080 -f -C -q -N threv@users.freeshells.org
