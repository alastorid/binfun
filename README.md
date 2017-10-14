# fdump

A simple tool to dump function binary code from binary elf.  Note that it doesn't corp with call. Any function contains call to other function will fail definitely.

## Tutorial

1. Firstly, put on auto completion.
    ````
    . ./source_me
    ````
2. Next, compile fun_add.c
    ````
    gcc ./fun_add.c
    ````
3. View all functions (except internal functions)
    ````
    ./fdump.sh -list ./a.out
    ````
4. Let's dump that fun\_add function. fun\_add is a function that increases the value which pointed by the first argument by 1.
    ````
    ./fdump.sh -dump ./a.out fun_add
    ````
5. Dump just the hex stuff.
    ````
    ./fdump.sh -dumphex ./a.out fun_add
    ````
6. Dump to C and make it callable.
    ````
    ./fdump.sh -dumpc ./a.out fun_add
    ````
7. Modify the function prototype to let we pass arguments. I've done that for you in example.c . So we just see and compile the example.c .
    ````
    gcc ./example.c
    ````
8. Test it. Done!
    ````
    ./a.out
    ````

# explore functions with
./fdump.sh [tab]
````

## Screenshoots

![](/sc1.png)