section .data	
	gui		db "-"
	vectore dw "9","9","9","9","9","0","9","9","9","1"
	end		db 10
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
		mov ecx,max
		mov eax,4      
        mov ebx,1        
        mov edx,1
        int 80h

        mov ecx,min
		mov eax,4      
        mov ebx,1        
        mov edx,1
        int 80h
mov eax,1
mov ebx,0
int 80h
