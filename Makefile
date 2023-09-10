GNU ?= x86_64-elf-

mbr.img: mbr.S
	$(GNU)gcc -ggdb -c $<
	$(GNU)ld mbr.o -Ttext 0x7c00
	$(GNU)objcopy -S -O binary -j .text a.out $@
run: mbr.img
	qemu-system-x86_64 $<

debug: mbr.img
	qemu-system-x86_64 -s -S $< &
	$(GNU)gdb -x init.gdb


clean:
	rm -rf *.img *.o a.out
