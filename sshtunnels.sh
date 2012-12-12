#!/bin/sh

autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6669:irc.choopa.net:6669 threv@bellplantationmarketing.com
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6666:chat.freenode.net:6666 threv@bellplantationmarketing.com
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6697:ircs.cmgdigital.com:6697 threv@bellplantationmarketing.com
autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 6667:im.bitlbee.org:6667 threv@bellplantationmarketing.com

privoxy /usr/local/etc/privoxy/config
