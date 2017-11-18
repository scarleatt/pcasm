%include "asm_io.inc"

segment .data
sum dd 0

segment .bss
input resd 1

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha
	
	mov edx, 1
while_loop:
	push edx
	push dword input
	call get_int
	add esp, 8

	mov eax, [input]
	cmp eax, 0
	je end_while
		
	add [sum], eax
	inc edx
	jmp short while_loop	
end_while:
	push dword [sum] 
	call print_sum
	add esp, 4		

	popa
	leave 
	ret

segment .data
prompt db ") Enter an integer number (0 to quit): ", 0

segment .text
get_int:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+12]
	call print_int
	mov eax, prompt
	call print_string

	call read_int
	mov ebx, [ebp+8]
	mov [ebx], eax
	
	pop ebp
	ret

segment .data
result db "The result is ", 0

segment .text
print_sum:
	push ebp
	mov ebp, esp

	mov eax, result
	call print_string
	
	mov eax, [ebp + 8]
	call print_int
	call print_nl
	
	pop ebp
	ret
