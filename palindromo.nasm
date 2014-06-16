;distintos A=!a
%macro print 2
mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro
section .data
		;cade1 db "abcdefgfedcba"
		cade1 db "madam"
		leng  equ $-cade1
		sip   db "si"
		no    db "no"
section .bss
		buffer: resb 100
section .text
	global _start
_start:
	mov eax,cade1
	mov ebx,(cade1+leng-1)
	mov ecx,(leng/2)
	_for:
		mov dl,[eax]
		cmp [ebx],dl
		jne _no
		inc eax
		dec ebx
	loop _for

_si:
	print sip,2
	mov eax,1
	mov ebx,0
	int 80h
_no:
	print no,2

	mov eax,1
	mov ebx,0
	int 80h
