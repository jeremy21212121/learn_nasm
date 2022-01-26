#!/bin/bash
set -e;

PROJ_DIR=~/projects/nasm;
BIN_DIR=$PROJ_DIR/bin;
SRC_DIR=$PROJ_DIR/src;

#cd $PROJ_DIR;

BINARY_FILE=$BIN_DIR/$1;
OBJECT_FILE=$PROJ_DIR/$1.o;
SRC_FILE=$SRC_DIR/$1.asm;

if test -f "$BINARY_FILE"; then
  rm $BINARY_FILE;
  echo "->  removed binary file";
fi

if test -f "$OBJECT_FILE"; then
  rm $OBJECT_FILE;
  echo "->  removed object file";
fi

nasm -o $OBJECT_FILE -f elf $SRC_FILE && ld -m elf_i386 $OBJECT_FILE -o $BINARY_FILE;

if test -f "$BINARY_FILE"; then
  echo "Success! New binary file -> ${BINARY_FILE}";
else
  echo "* ERROR - Binary file was not created.";
fi
