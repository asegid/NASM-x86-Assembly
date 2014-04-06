;nasm -f coff NumberInfo.asm
;gcc -o NumberInfo NumberInfo.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data
	prompt db "Enter the number: ", 0
	square db "The square of the number is ", 0
	cube db "The cube of the number is ", 0
	quotient db "The quotient of the number/100 is ", 0
	remainder db "The remainder of the number/100 is ", 0
	negative db "The negation of the number is ", 0

segment .bss
	input resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt
	call print_string
	
	call read_int
	mov [input], eax
	
	imul eax
	mov ebx, eax
	mov eax, square
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	
	mov ebx, eax
	imul ebx, [input]
	mov eax, cube
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	
	mov eax, [input]
	cdq
	mov ecx, 100
	idiv ecx
	mov ecx, eax
	mov eax, quotient
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	
	mov eax, remainder
	call print_string
	mov eax, edx
	call print_int
	call print_nl
	
	mov eax, negative
	call print_string
	mov eax, [input]
	neg eax
	call print_int
	call print_nl
	
	popa
	mov	eax, 0
	leave
	ret