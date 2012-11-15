#!/bin/sh

sudo find / -size +50M -exec ls -lh {} \; | awk '{print $5,$9,$10,$11,$12,$13,$14,$15,$16}' | sort -nr | less
