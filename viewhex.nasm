section .data
    mensaje     db  10,"---vamos a probar esto---",10,10
    longitud    equ $ - mensaje
    mensaje2    db  10,"---hemos terminado---",10
    longitud2   equ $ - mensaje2
    tamano      equ 1024
    msgerror    db  10,"Hay un error al leer el fichero",10
    errorlen    equ $-msgerror   
    msguion     db "-"    
    msgnewline  db 10  
    msgspace    db "_"

section .bss
    buffer:     resb 1
section .text
    global _start

_start:
    mov edx,longitud
    mov ecx,mensaje
    mov ebx,1
    mov eax,4
    int 80h
 ;pop arguments
    pop ebx 
    pop ebx
 ;testeo para ver la uri
 ;       mov eax,4
 ;       mov ebx,1
 ;       pop ecx         ;mostramos argumento
 ;       mov edx,29
 ;       push ecx        ;volvemos a ponerlo en stack
 ;       int 80h
 ;end testo

 ;abrir fichero
    mov eax,5       ; open(
    pop ebx         ; url del archivo
    mov ecx,0       ; read-only mode
    int 80h         ; );
; end abrir

test eax,eax        ; cambia los flags, solo flags
jns leer_del_fichero    ; si !=0 leer archivo si ==0 hubo problemas
    hubo_error: 
        mov eax,4           ; write(
        mov ebx,1           ;   STDOUT,
        mov ecx,msgerror    ;   *buf
        mov edx,errorlen    ; );
        int 80h
        jmp fin

leer_del_fichero:   
    mov eax,3              ; read(
    mov ebx,eax             ;   file_descripor,
    mov ecx,buffer          ;   *buf,
    mov edx,tamano          ;   *bufsize
    int 80h                 ; );
test eax,eax

jns mostrar_por_pantalla ; cambia los flags, solo flags
jmp hubo_error
mostrar_por_pantalla:
;    mov eax,4              ;write(
;    mov ebx,1              ; STDOUT,
    ;mov ecx,buffer        ; *buf
;    push ecx               ; guardamos en stack 
;    int 80h                ; );

;Separa de 8 en 8 los grupos
mov ecx,buffer
push ecx                    ;save ecx, the string
mov edi,2
mov ebp,0
 comienzo:
    dec edi
    pop ecx
    cmp byte[ecx], 0        ;EOF archivo
        je fin              ;si EOF true
          mov esi,8
          for:
            cmp esi,0
            je guion
                   ;print 1 character
                    mov eax,4
                    mov ebx,1
                    ; verificar si no es character especial
                        cmp ecx,msgnewline      ;si es /n
                           jne conti1
                              mov ecx,msgspace
                           jmp conti1
                    ;end verificar
                    conti1:
                    mov edx,1 
                    int 80h
                    inc ecx
                    dec si
                   ;end character
          jmp for
          guion:                    ; cada 8 imprime
            not ebp                 ;ebp=!ebp
            push ecx                ;save ecx
            mov eax,4
            mov ebx,1

            cmp ebp,0
            je continue
           
            mov ecx,msguion
            mov edx,1
            int 80h
    continue:
    cmp edi,0
    jnz comienzo
    reset:
      mov edi,2
      mov eax,4
      mov ebx,1
      mov ecx,msgnewline
      mov edx,1
      int 80h
  jmp comienzo
;end separa




; fin
fin:
mov ebx,0
mov eax,1
int 80h
