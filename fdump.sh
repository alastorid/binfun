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
  dump $1 $2| sed '1 d;/  [0-9a-f]/ s/^  [0-9a-f]\+:[\t ]\([0-9a-f]\{2\}\)\(\( [0-9a-f]\{2\}\)*\).*$/\1\2/'|tr '\n' ' '
  echo ""
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
  *)
    usage
  ;;
esac

