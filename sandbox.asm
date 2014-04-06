;nasm -f coff sandbox.asm
;gcc -o sandbox sandbox.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data

prompt1 db "Enter a number: ", 0
prompt2 db "You entered: ", 0

segment .bss

input resd 0

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	push prompt1
	push dword input
	call get_input
	pop ebx
	pop ebx
	
	push dword[input]
	call print
	pop ebx
	
	popa
	mov	eax, 0
	leave
	ret	

get_input:
	enter 0,0
	
	mov eax, [ebp+12]
	call print_string
	
	call read_int
	mov ebx, [ebp+8]
	mov [ebx], eax
	
	leave
	ret
	
print:
	enter 0,0
	
	mov eax, prompt2
	call print_string
	
	mov eax, [ebp+8]
	call print_int
	call print_nl
	
	leave
	ret
	