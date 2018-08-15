#!/bin/bash

exec 5<> /dev/tcp/host/port
cat <&5 &
printf "GET / HTTP/1.0\r\n\r\n" >&5
