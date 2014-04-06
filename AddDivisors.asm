;nasm -f coff sandbox.asm
;gcc -o sandbox sandbox.o driver.c asm_io.o

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl

segment .data

prompt db "Enter a number: ", 0
stringDivisors db "The divisors are:", 0
stringSum db "The sum of these divisors (not including the original number) is ", 0
perfectNum db " is a perfect number.", 0
primeNum db " is a prime number.", 0
period db '.'

segment .bss

input resd 1
sum resd 1

segment .text
	global _asm_main
_asm_main:
	enter 0,0
	pusha
	
	mov eax, prompt
	call print_string
	
	call read_int
	call print_nl
	mov [input], eax
	
	mov eax, stringDivisors
	call print_string
	call print_nl
	
	mov dword[sum], 0
	mov ecx, 1
	
;for (int i = 1; i < input, i++)
;	if (input % i == 0)
;		sum += i;
for_loop:
	
	cmp ecx, [input]
	jge end_loop
	
	mov eax, [input]
	
	cdq
	idiv ecx
	
	cmp edx, 0
	je is_divisor
	
	add ecx, 1
	jmp for_loop
	
is_divisor:
	
	add [sum], ecx
	mov eax, ecx
	call print_int
	call print_nl
	
	add ecx, 1
	jmp for_loop
	
end_loop:

	mov eax, [input]
	call print_int
	call print_nl
	
	call print_nl
	mov eax, stringSum
	call print_string
	mov eax, [sum]
	call print_int
	mov eax, [period]
	call print_char
	call print_nl

	mov eax, [sum]
	cmp eax, [input]
	je is_perfect
	jmp end_is_perfect
	
is_perfect:
	
	mov eax, [input]
	call print_int
	mov eax, perfectNum
	call print_string

end_is_perfect:
	
	mov eax, [sum]
	cmp eax, 1
	je is_prime
	jmp end_is_prime

is_prime:

	mov eax, [input]
	call print_int
	mov eax, primeNum
	call print_string

end_is_prime:
	
	leave
	ret
	