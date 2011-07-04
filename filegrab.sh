#!/bin/sh

echo "Multi-File Downloader!"
echo "File Type:  "
read filetext
echo "Directory to save files:  "
read dirtext
echo "URL to grab:  "
read urltext
echo "OPTIONAL:  Special wget flags:  "
echo "Most useful:  -X/<directory to reject>, --ignore-tags=<tags to ignore>"
read flagstext


if [[ ! -d "$dirtext" ]];
then
    mkdir $dirtext
fi

cd $dirtext

wget -r -l1 -H -t1 -nd -N -np -A.$filetext -erobots=off $flagstext $urltext
