# fdump

A simple tool to dump function binary code from binary elf.  Note that it doesn't corp with call. Any function contains call to other function will fail definitely.

## how to use?

````
. ./source_me
./fdump.sh -dumphex ./a.out fun_add
# explore functions with
./fdump.sh [tab]
````

## Screenshoots

![](/sc1.png)