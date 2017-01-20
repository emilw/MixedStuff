cat EmilWestholm_Lab4.md | iconv -c -f utf-8 -t ISO-8859-1 > EmilWestholm_Lab4_ASCII.md
a2ps EmilWestholm_Lab4_ASCII.md -o EmilWestholm_Lab.ps
ps2pdf EmilWestholm_Lab.ps
