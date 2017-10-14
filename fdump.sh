#!/bin/bash
function usage(){
    echo "$0 [OPTION] [binary elf] [function name]"
    echo "  -dump dump function from an elf binary"
    echo "  -list list all function name inside a elf binary"
}
function dump(){
  objdump -Mintel -d $1|sed -n '/<'$2'>/{p;:a;n;/[0-9a-f]\{8,16\} <[^>]\+>/q;p;ba};'
}
function list(){
  objdump -d $1|sed -n '/[0-9a-f]\{8,16\} <[^>]\+>/{s/^[^<]*<\([^>]*\)>.*$/\1/;p}' |sed '/_init\|.plt.got\|_start\|@plt\|deregister_tm_clones\|register_tm_clones\|__do_global_dtors_aux\|frame_dummy\|__libc_csu_fini\|_fini/d'
}
function dumphex(){
  dump $1 $2| sed '1 d;/  [0-9a-f]/ s/^  [0-9a-f]\+:[\t ]\([0-9a-f]\{2\}\)\(\( [0-9a-f]\{2\}\)*\).*$/\1\2/'|tr '\n' ' '|sed 's/  / /g'
  echo ""
}
function dumpc(){
  local code
  code=$(dumphex $1 $2|sed 's/^\|[ ]\([0-9a-f]\{2\}\)/\\\\x\1/g;s/ //g')
  printf "#include <sys/mman.h>\n"\
"#include <unistd.h>\n"\
"#include <string.h>\n"\
"typedef int (*p$2)();\n"\
"unsigned char *uc$2=\"$code\";\n"\
"\n"\
"p$2 init_$2()\n"\
"{\n"\
"  size_t sz$2="`expr $(echo $code|wc -c) / 4`";\n"\
"  p$2 pf=(p$2)mmap(NULL, sz$2, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, -1, 0);\n"\
"  memcpy(pf,uc$2,sz$2);\n"\
"  return pf;\n"\
"}\n"\
"\n"\
"// Modify the typedef line above to match your dumped function.\n"\
"// An example of calling the binary function.\n"\
"//-------------------------\n"\
"//   p$2 $2=init_$2();\n"\
"//   $2();\n"\
"//-------------------------\n"
}
if [ $# -lt 1 ] ;then usage; exit ;fi

case $1 in
  -list)
    list $2
  ;;
  -dump)
    dump $2 $3
  ;;
  -dumphex)
    dumphex $2 $3
  ;;
  -dumpc)
    dumpc $2 $3
  ;;
  *)
    usage
  ;;
esac

