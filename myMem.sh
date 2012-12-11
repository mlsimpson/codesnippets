#!/bin/sh

vm_stat|awk 'NR==2'|sed 's/\.//'|awk '{print $3 * 4096 / 1024 / 1024 "M"}'
