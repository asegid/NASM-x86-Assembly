;nasm -f coff skel.asm
;gcc -o skel skel.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data

	prompt1 db "Enter a number: ", 0
	prompt2 db "Enter another number: ", 0
	
	output1 db "The average of these numbers is", 0

segment .bss

	input1 resd 1
	input2 resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt1
	call print_string
	
	call read_int
	mov [input1], eax
	
	mov eax, prompt2
	call print_string
	
	call read_int
	mov [input2], eax
	
	mov eax, [input1]
	
	imul eax, [input2]
	call print_int

	popa
	mov	eax, 0
	leave
	ret