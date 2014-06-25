;1.-Dado un archivo mostrat las vocales                                           Listo
;2.-Dado un archivo mostrar las vocales de forma inversa y ver si es              Espera
;   palindromo
%macro print_generic 2
		mov eax,4
		mov ebx,1
		mov ecx,%1
		mov edx,%2
		int 80h
%endmacro
section .data
		tamano      equ      1000
		endl 		db 10
		vocales 	db "a","e","i","o","u","A","E","I","O","U"
		space		db " "
section .bss
		buffer:     resb 1000
section .text
		global _start
_start:
		;extract arguments 
		pop ecx 
    	pop ecx
    	pop ecx
		push ecx
print_generic ecx,8
print_generic endl,1
open_file:
    mov eax,5              ; open(
    pop ebx                ; url del archivo
    mov ecx,0              ; read-only mode
    int 80h                ; );
read_file:
 	mov eax,3               ; read(
   	mov ebx,eax             ;   file_descripor,
    mov ecx,buffer          ;   *buf,
    mov edx,tamano          ;   *bufsize
    int 80h  				; );
print_generic buffer,tamano
print_generic endl,1
kernel:
	mov ecx,buffer
	push ecx
		_for:
			cmp byte[ecx],0				;end of file or eof
			je _endfor					;jump no equal
			  ;compare if is a vocal a,e,i,o,u				
					cmp byte[ecx],'a'
					 jne no_a
					  push ecx
					   print_generic ecx,1
					  pop ecx
				no_a:
					cmp byte[ecx],'e'
					 jne no_e
					  push ecx
					   print_generic ecx,1
					  pop ecx
				no_e:
					cmp byte[ecx],'i'
					 jne no_i
					  push ecx
					   print_generic ecx,1
					  pop ecx
			    no_i:
					 cmp byte[ecx],'o'
					 jne no_o
					  push ecx
					   print_generic ecx,1
					  pop ecx 	
				no_o:
					  cmp byte[ecx],'u'
					 jne no_vocal
					  push ecx
					   print_generic ecx,1
					  pop ecx
				no_vocal:
					push ecx
					print_generic space,1
					pop ecx
					cmp byte[ecx],' '
					jne no_space

					push ecx
					print_generic space,1
					pop ecx
			  ;end compare vocal
			no_space:
			inc ecx 					;index ++
			jmp _for 					;continue cicle
		_endfor:
fin:		
		mov ebx,0
		mov eax,1
		int 80h
