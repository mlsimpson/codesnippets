#!/usr/bin/env python
import sys
import re

if (len(sys.argv) < 2 or sys.argv[1] == "-h" or sys.argv[1] == "--help"):
    print "A tool for converting .smc SNES ROM files to .sfc format."
    print "Unless specified it creates a new file of the same name as the"
    print "orginal, but with a .sfc extension, overwriting any old file in the"
    print "current directory."
    print "Usage: \n\t" + sys.argv[0] + " input_file [output_file]"
    sys.exit(1)

if (sys.argv[1][-3:] != "smc"):
    userinput = "none"
    while (userinput.lower() != "y" and userinput.lower() != "n"):
        userinput = raw_input("file does not end in .smc, proceed? (Y/n)")
    if (userinput.lower() == "n"):
        sys.exit(2)

fin = open(sys.argv[1], "rb")

i=0
while (i < 512):
    c = fin.read(1)
    if ((i == 8 and c != "\xaa") or (i == 9 and c != "\xbb")):
        print "input file does not seem to be in SMC format, ending..."
        sys.exit(3)
    if (c == ""):
        print "file too short"
        sys.exit(4)
    i += 1

if (len(sys.argv) == 3):
    newname = sys.argv[2]
else:
    newname = re.sub(r"\..*$", r".sfc", sys.argv[1])
fout = open(newname, "wb")

while (c != ""):
    c = fin.read(1)
    fout.write(c)
