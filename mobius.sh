#!/bin/zsh

wget http://archive.wrek.org/main/128kb/Wed2000.mp3
wget http://archive.wrek.org/main/128kb/Wed2030.mp3

sox Wed2000.mp3 Wed2030.mp3 /mnt/SkyHawk/Mobius\ Archives/TheMobius-`date +"%Y-%m-%d"`.mp3

DATE=$(date +"%Y-%m-%d")
TITLE='The Mobius - '$DATE
ARTIST='The Mobius'
ALBUM='The Mobius on WREK Atlanta 91.1 FM'
YEAR=$(date +"%Y")

mid3v2 -y $YEAR -t $TITLE -a $ARTIST -A $ALBUM --TPE2 $ARTIST /mnt/SkyHawk/Mobius\ Archives/TheMobius-`date +"%Y-%m-%d"`.mp3
mid3v2 --COMM "Every Wednesday from 7 to 9pm EST on WREK Atlanta 91.1 FM, broadcasting from the heart of Georgia Tech.  www.wrek.org || themobius.livejournal.com" /mnt/SkyHawk/Mobius\ Archives/TheMobius-`date +"%Y-%m-%d"`.mp3
eyeD3 --add-image /mnt/SkyHawk/Mobius\ Archives/cover.png:FRONT_COVER /mnt/SkyHawk/Mobius\ Archives/TheMobius-`date +"%Y-%m-%d"`.mp3

rm Wed*.mp3
