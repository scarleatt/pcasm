%include "asm_io.inc"
segment .data
sum db 0
prompt db "Calc the sum 1..", 0
result db "The result is ", 0

segment .bss
n resd 1
sump resd 1

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov eax, prompt
	call print_string
	call read_int
	mov [n], eax
	
	push dword [n]
	push sump
	call calc_sum		
	add esp, 8
	
	mov eax, result
	call print_string
	mov eax, [sump]
	call print_int
	call print_nl

	popa
	leave 
	ret

segment .text
calc_sum:
	push ebp
	mov ebp, esp
	sub esp, 4	
	
	mov dword [ebp-4], 0
	mov ebx, 1
for_loop:
	cmp ebx, [ebp+12]
	jnle end_for

	add [ebp-4], ebx
	inc ebx
	jmp short for_loop
end_for:
	mov ebx, [ebp+8]
	mov eax, [ebp-4]
	mov [ebx], eax	
	
	mov esp, ebp
	pop ebp
	ret
