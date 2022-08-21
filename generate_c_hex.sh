#! /bin/bash

set -e

BUILD_DIR=build
mkdir -p $BUILD_DIR

riscv32-unknown-elf-gcc ./src/C/$1.c -o $BUILD_DIR/$1
riscv32-unknown-elf-objcopy -O binary $BUILD_DIR/test1 $BUILD_DIR/test1.bin
od -An -tx1 -w1 -v $BUILD_DIR/test1.bin > ./src/hex/test1.hex