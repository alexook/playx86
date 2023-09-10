ARCH ?= x86_64-elf-

mbr.img: mbr.S
	$(ARCH)gcc -ggdb -c $<
	$(ARCH)ld mbr.o -Ttext 0x7c00
	$(ARCH)objcopy -S -O binary -j .text a.out $@
run: mbr.img
	qemu-system-x86_64 $<

debug: mbr.img
	qemu-system-x86_64 -s -S $< &
	$(ARCH)gdb -x init.gdb


clean:
	rm -rf *.img *.o a.out
