#! /bin/bash

set -ex

BUILD_DIR=build
mkdir -p $BUILD_DIR

riscv32-unknown-elf-gcc ./src/C/$1.c -g -march=rv32i -mabi=ilp32 -o $BUILD_DIR/$1
# -T ./src/C/link.ld
riscv32-unknown-elf-objcopy -O binary $BUILD_DIR/test1 $BUILD_DIR/test1.bin
od -An -tx1 -w1 -v $BUILD_DIR/test1.bin > ./src/hex/test1.hex