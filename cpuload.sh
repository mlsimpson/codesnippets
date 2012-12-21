#!/bin/sh

uptime | awk '{x=(NF-2); print $x}'
