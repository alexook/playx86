#define SECT_SIZE 512


.code16

.globl _start

_start:
	lea	(msg), %si

again:
	movb (%si), %al
	incw %si
	orb %al, %al
	jz done
	movb $0x0e, %ah
	movb $0x00, %bh
	int $0x10
	jmp again


done:
	jmp .


msg:
	.asciz "this is a toy operating system\r\n"

.org SECT_SIZE - 2
.byte 0x55, 0xAA
