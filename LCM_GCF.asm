;nasm -f coff LCM_GCF.asm
;gcc -o LCM_GCF LCM_GCF.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data

prompt1 db "Enter a number: ",0
prompt2 db "Enter another number: ",0

segment .bss

n1 resd 0
n2 resd 0

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt1
	call print_string

	call read_int
	mov [n1],eax
	
	mov eax, prompt2
	call print_string
	
	call read_int
	mov [n2], eax
	
	push dword n1
	push dword n2
	call LCM
	call print_int
	add esp, 8
	
	push dword n1
	push dword n2
	call GCF
	call print_int
	add esp, 8
	
	leave
	ret

; int n1, n2
; for (int i = n1; n <= n1 * n2; n+=n1) {
;      if (i % n1 == 0 && i % n2 == 0) {
;            return i;
;		}
; }	
LCM:
	enter 0,0
	push esi
	
	mov eax, [ebp+12]
	imul [ebp+8]
	mov ecx, eax
LCM_loop:	
	cdq
	idiv [ebp+12]
	
	cmp edx, 0
	je short LCM_end
	
	mov edx, ebx
	mov eax, esi
	xor edx, edx
	div ebx
	mov ebx, edx
	mov eax, ecx
	mov esi, eax
	
	jle LCM_loop
LCM_end:
	pop esi
	
	mov ebx, eax
	xor edx, edx
	div gcd
	imul eax
	
	leave
	ret

; int n1, n2
; for (int i = n1; i <= n1 *  n2; i += n1) {
;     if (n1 % i == 0 && n2 % i == 0) {
;          return i;
;     }
; }
GCF:
	enter 0,0
	
GCF_loop:
	div ebx
	
	mov eax, ebx
	mov ebx, edx
	xor edx, edx
	cmp ebx, 0
	
	jnz GCF_loop
	
	leave
	ret