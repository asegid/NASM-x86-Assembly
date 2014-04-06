;nasm -f coff LCM_GCF.asm
;gcc -o LCM_GCF LCM_GCF.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

section .data
	msg1	db	"Enter the number : "
	size1	equ	$-msg1
	msg2	db	"Enter a number:"
	size2	equ	$-msg2
	msg3	db	"Sorted Array : "
	size3	equ $-msg3

section .bss
  digit0	resb	1
  digit1	resb	1
  digit2	resb	1
  digit3	resb	1
  digit4	resb	1
  temp	resb	1
  num	resb	1
  n	resw	1
  nod	resb	1
  num1	resb	1
  num2	resb	1
  factorial	resw	1

section .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha

;Prompt number
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, size1
	
	call print_int
  
;Read number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	
	call read_int

	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 1
	
	call read_int

	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1

	call read_int

	mov al, byte[digit1]
	mov dl, 10
	mul dl
	mov byte[num], al
	mov al, byte[digit0]
	add byte[num], al
	mov al, byte[num]
	mov ah,0
	mov word[n], ax

	call factorial

	mov word[factorial], cx
	mov ax, word[factorial]

	mov word[num], ax
	mov byte[nod], 0;

get_digits:
	cmp word[num], 0
	je print_no
	
	inc byte[nod]
	mov dx, 0
	mov ax, word[num]
	mov bx, 10
	div bx
	mov word[num], ax
	jmp get_digits
	
print_digit:
	cmp byte[nod], 0
	je end_print
	dec byte[nod]
  
	mov byte[temp], dl
	add byte[temp], 30h

	mov eax, 4
	call print_int

	jmp print_digit

end_print:  
	mov eax, 1
	mov ebx, 0

factorial:
	mov ax, word[n]
	
	cmp ax, 1
	je exit_recusion

	push word[n]

	dec word[n]
	call fact

	pop word[n]
	mov dx, word[n]

	mov ax, cx
	mul dx
	mov cx, ax
	jmp finish
  
exit_recursion:
	mov cx, 1

finish:
  ret