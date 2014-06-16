section .data
		cade1	db "azol mas"
		len     equ $-cade1
section .text
	global _start
_start:
	mov ecx,len/2
	cmp ecx,0
	je fin				;SIN ES UN SOLO CARACTER
			;inc ecx
			mov eax,cade1+len-1 ;fin
			mov ebx,cade1		;inicio
			mov esi,0
			_for:
				push ecx			;index
				
				mov byte dl,byte[eax]
				mov byte dh,byte[ebx]

				mov ecx,len-1
				sub ecx,esi
				;begin swap
					mov [cade1+ecx],dh 	;principio
					mov [cade1+esi],dl		;fin
				;end swap
				inc ebx
				inc esi 
				dec eax
				
				pop ecx		;index
			loop _for
fin:
			mov eax,4
			mov ebx,1
			mov ecx,cade1
			mov edx,len
			int 80h

mov eax,1
mov ebx,0
int 80h
