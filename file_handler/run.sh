#!/bin/sh

mkdir -p out

for file in $(find src -type f); do
    nasm -f elf64 "$file" -o "out/$(basename "${file%.asm}").o"
done

ld out/* -o app 
./app
