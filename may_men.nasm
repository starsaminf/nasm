%macro print_generic 2
        mov eax,4           ; write(
        mov ebx,1           ;   STDOUT,
        mov ecx,%1          ;   *buf
        mov edx,%2          ; );
        int 80h
%endmacro
section .data	
	gui		db "-"
	vectore dw "9","9","9","6","8","6","9","9","9","1"
	end		db 10
	space 	db " "
	min 	db '9'
	max 	db '0'
section .bss
section .text

global _start
	_start:

mov eax,vectore
mov ecx,20
_for:
		push ecx
		push eax

		mov byte dl,byte[eax]
		cmp dl,[max]
		jge asig_may		;si mayor swap
		jmp conti 			;si menor repite for
			asig_may:
				mov[max],dl
	conti:
		cmp dl,[min]
		jle asig_men
		jmp conti2
			asig_men:
				mov[min],dl

	conti2:

	pop eax
	pop ecx
	inc eax
	inc eax	
dec ecx				;solo por molestar 
loop _for
		print_generic max,1
		print_generic space,1
		print_generic min,1
mov eax,1
mov ebx,0
int 80h
