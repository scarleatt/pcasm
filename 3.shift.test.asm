%include "asm_io.inc"
segment .data

segment .bss
input resd 1

segment .text 
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov bl, 0
	mov ecx, 32
count_loop:
	shl eax, 1
	jnc skip_inc
	inc bl
skip_inc:
	loop count_loop
	
	call print_int
	call print_nl

	popa
	mov eax, 0
	leave
	ret
