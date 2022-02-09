#!/bin/bash
set -e

echo "[?] Checking submodules ..."
git submodule init
git submodule update

#git submodule update --init --recursive

echo "[?] Checking QEMU-NYX ..."
if [ ! -f "qemu-nyx/x86_64-softmmu/qemu-system-x86_64" ]; then
	echo "[*] Compiling QEMU-NYX ..."
	cd qemu-nyx
	./compile_qemu_nyx.sh static
	cd -
fi

echo "[?] Checking NYX-Net fuzzer ..."
if [ ! -f "fuzzer/rust_fuzzer/target/release/rust_fuzzer" ]; then
	echo "[*] Compiling NYX-Net fuzzer ..."
	cd fuzzer/
	./setup.sh
	cd ..
fi

echo "[*] Compiling AFL++ clang compiler ..."
cd AFLplusplus
make -j
cd -

echo "[*] Preparing Initramfs..."
cd packer/linux_initramfs/
sh pack.sh
cd -

echo "[*] Done ... "
