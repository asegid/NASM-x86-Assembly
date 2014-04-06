;nasm -f coff PrimeSearch.asm
;gcc -o PrimeSearch PrimeSearch.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data
	prompt db "Find primes up to: ", 0
	current dd 3

segment .bss
	limit resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	; Prompt and get limit
	mov eax, prompt
	call print_string
	call read_int
	mov [limit], eax
	
	; Print special case of 2
	mov eax, 2
	call print_int
	call print_nl
	
while_limit: ;while current <= limit
	mov eax, [current]
	cmp eax, [limit]
	jg end_while_limit
	mov ebx, 3 
while_factor: ;check factors
	mov eax, ebx
	mul eax
	cmp eax, [current]
	jge end_while_factor
	mov eax, [current]
	mov edx, 0
	div ebx
	cmp edx, 0
	je end_while_factor
	add ebx, 2
	jmp while_factor
end_while_factor:
	je end_if
	mov eax, [current]
	call print_int
	call print_nl
end_if:
	mov eax, [current]
	add eax, 2
	mov [current], eax
	jmp while_limit
end_while_limit:	
	popa
	mov	eax, 0
	leave
	ret	