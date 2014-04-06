;nasm -f coff sandbox.asm
;gcc -o sandbox sandbox.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data

prompt1 db "Enter the numerator of fraction 1: ", 0
prompt2 db "Enter the denominator of fraction 1: ", 0
prompt3 db "Enter the numerator of fraction 2: ", 0
prompt4 db "Enter the denominator of fraction 2: ", 0
slash db "/", 0
plus db " + ", 0
equals db " = ", 0

segment .bss

num1 resd 1
denom1 resd 1
num2 resd 1
denom2 resd 1
sumnum resd 1
sumdenom resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt1
	call print_string
	call read_int
	mov [num1], eax
	
	mov eax, prompt2
	call print_string
	call read_int
	mov [denom1], eax
	
	mov eax, prompt3
	call print_string
	call read_int
	mov [num2], eax
	
	mov eax, prompt4
	call print_string
	call read_int
	mov [denom2], eax
	
	mov eax, [num1]
	call print_int
	mov eax, slash
	call print_string
	mov eax, [denom1]
	call print_int
	mov eax, plus
	call print_string
	mov eax, [num2]
	call print_int
	mov eax, slash
	call print_string
	mov eax, [denom2]
	call print_int
	mov eax, equals
	call print_string
	
	mov eax, [num1]
	imul dword[denom2]
	mov ebx, eax
	mov eax, [num2]
	imul dword[denom1]
	add ebx, eax
	
	mov eax, ebx
	call print_int
	
	mov eax, slash
	call print_string
	
	mov eax, [denom1]
	imul dword[denom2]
	call print_int
	
	cdq
	
; for (int i = 0; i <= sumdenom, i++)
;	if (sumnum % i == 0) {
;		if (sumdenom % i == 0)
;			sumnum /= i;
;			sumdenom /= i;
;			break;
; check_factors:
	; mov ecx, 0
; for_loop:
	; mov eax, [sumnum]
	; idiv ecx
	; cmp edx, 0
	; je check_denom
	; jmp check_conditions_and_loop
; check_denom:
	; mov eax, [sumdenom]
	; idiv ecx
	; cmp edx, 0
	; je reduces
	; jmp check_conditions_and_loop
; check_conditions_and_loop:
	; add ecx, 1
	; cmp ecx, [sumnum]
	; jg end_factor_loop
	; jmp for_loop
; reduce:
; end_factor_loop:
	leave
	ret
	