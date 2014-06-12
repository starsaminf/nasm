%macro print_generic 2
        mov eax,4           ; write(
        mov ebx,1           ;   STDOUT,
        mov ecx,%1          ;   *buf
        mov edx,%2          ; );
        int 80h
%endmacro
section .data
    msgwelcome  db      10," +----------------------------------------------------------------+",10
                db         " |################################################################|",10
                db         " |######################Visor Hexadecimal Nasm####################|",10
                db         " |################################################################|",10
                db         " +----------------------------------------------------------------+",10
                db         " |                                                                |",10
    lenmsgwelcome equ    $-msgwelcome
    msgend      db       10, " +----------------------------------------------------------------+",10
    lenmsgend   equ      $-msgend
    msgerror    db       10,"author: Samuel Loza <starsaminf@gmail.com>"
                db       10,"Funciona con parametros",10,"Ejemplo:"
                db       10,"sam@Scarlet:~$./nombre_ejecutable [archivo]",10
    errorlen    equ      $-msgerror   
    msguion     db       " - "
    msgnewline  db       10  
    msgspace    db       "_"                                                      ;Remplaces space
    space       db       " "
    aux_flag    db       "0"
    flag        db       0
    flag_bug    db       0
    separator   db       "  |  "
    separator1  db       " | "
    zero        db       "0"
    numero      dw       0000
    numero2     dw       0000
    cadhex      dw       0000
    datahex     dw       0000
    tamano      equ      1000000000
section .bss
    buffer:     resb     1000000000
section .text
    global _start
_start:
  print_generic msgwelcome,lenmsgwelcome
    pop ebx                ;pop arguments
    pop ebx
;abrir fichero
    mov eax,5              ; open(
    pop ebx                ; url del archivo
    mov ecx,0              ; read-only mode
    int 80h                ; );
;Fin abrir fichero
test eax,eax                ; cambia los flags, solo flags
jns leer_del_fichero        ; si !=0 leer archivo si ==0 hubo problemas
    hubo_error:
        print_generic msgerror,errorlen 
        jmp fin
leer_del_fichero:   
    mov eax,3               ; read(
    mov ebx,eax             ;   file_descripor,
    mov ecx,buffer          ;   *buf,
    mov edx,tamano          ;   *bufsize
    int 80h                 ; );
test eax,eax
jns debug_mostrar           ; cambia los flags, solo flags
jmp hubo_error
  debug_mostrar:
      ;print_generic buffer,tamano
      ;push ecx
;KERNEL :S
mov ecx,buffer                              ;Guardamos el buffer en ecx, para recorrer como puntero
push ecx                                    ;push buffer
comienzo:
    pop ecx                 
    cmp byte[ecx], 0                                                      ;ecx compare 0 => EOF archivo
        je fin                                                            ;si EOF true
          push ecx                                                        ;save buffer
          cmp byte[flag],1
          je for4                                                         ;if(flag == true) print 0000 - 0007 
            call numerationdec
            mov byte[flag],0                                              ;cambia estado flag                        
          for4:                                                              
              mov byte[flag],1                                            ;cambia estado flag
              pop ecx                                                     ;pop buffer
              mov esi,4  ;Rango a imprimir                                                                                              
              for_n:                                                      ;while(esi !=0 ){
                      ;new alternative
                        push ecx                      
                          call print_hex
                            print_generic space,1                      
                        pop ecx                                               ;pop buffer                 
                          inc ecx                                               ;Puntero buffer++
                          push ecx                                              ;save buffer
                      ;new alternative => Dr :D
                      dec esi                                               ;rango impirmir--
                cmp esi,0                                                  ;  }
                jne for_n                                                    ;repite 2 para imprimir los dos rangos                    
                    cmp byte[aux_flag],'1'
                         je no_guion        
                         print_generic msguion,3
          no_guion:                                                          ; find imprime rango 0000 - 0000
          inc byte[aux_flag]
          cmp byte[aux_flag],'2'
jne comienzo
;___Imprime valores originales del archivo___
          print_generic separator,5          
          mov edi,2                                                         ;usado como flag
          mov ebp,0
          pop ecx                                                           ; pop buffer
          sub ecx,8                                                         ; puntero buffer retrocede
          push ecx                                                          ; push buffer

     comienzo2:
           pop ecx                                                           ;pop buffer
           dec edi                                                           ;flag = 1 or flag = 0
           mov esi,4          
          for:
            cmp esi,0
            je guion
           ;Inicio verificar si no es caracter especial
                        push ecx
                        cmp byte[ecx],10                        ;si es /n
                         jne jump_verifica 
                                 print_generic msgspace,1                                                         
                                  pop ecx  
                                  inc ecx
                                  dec esi
          jmp  for
          ;Fin verificar
                jump_verifica:
                    pop ecx
                        print_generic ecx,1        ;1er caracter          
                    inc ecx         ;buffer incrementa    
                    dec esi
          jmp for
          guion:                    ; cada 8 imprime
            not ebp                 ;ebp=!ebp flags
            push ecx                ;push ecx
            cmp ebp,0
          je continue         
            print_generic msguion,3
          continue:
            cmp edi,0
     jnz  comienzo2
  jmp  newline
       newline: 
              print_generic separator1,3
              print_generic msgnewline,1
              mov byte[aux_flag],'0'    
              mov byte[flag],0 
jmp comienzo
;Fin KERNELl
fin:
    print_generic msgend,lenmsgend
    mov ebx,0
    mov eax,1
    int 80h
;_______Funciones____________
print_hex:
  xor edx,edx
  movzx edx, byte[ecx]                                  ;transformacion                          
  mov dword[datahex],edx
  mov ah,[datahex]
  and ah,0x0f             ;1111
  add ah,30h              ;'0'
  cmp ah,39h              ;'9'
  jle noesletra1
  add ah,7              ;'9'+7 = A

noesletra1: 
  mov byte[cadhex+1],ah  
  mov ah,[datahex]
  shr ah,4              ;mueve los 4 primeros bits a los ultimos
  add ah,30h            ;convierte a num
  cmp ah,39h            
  jle noesletra2          ;ah <= 9
  add ah,7                ;ah + 7 ='A'
noesletra2:
  mov byte[cadhex],ah
  print_generic cadhex,2
  ;Cerear cadhex,datahex
  mov dword[cadhex] ,0000
  mov dword[datahex],0000
ret
;___Print(begin_i - end _j); numeracion lado izquierdo___
numerationdec:
     print_generic separator1,4     ; |
     
     mov byte[flag_bug],0
     call rellenar    
     call print_dec                 ;  00000

     add dword[numero],dword 8       
     print_generic msguion,3        ;  -

     mov byte[flag_bug],1
     call rellenar
     call print_dec                 ;  00000

     add dword[numero],dword 1
     print_generic separator,5      ;  |
ret

print_dec:
  mov ax,[numero]
  mov cx,10
  mov esi,4
  convertir:
    xor dx,dx
    div cx
    add dx,'0'
    mov[numero2 + esi],dl
    dec esi
    mov cx,10
    cmp ax,0
  jne convertir
 print_generic numero2,5
ret

rellenar:
 cmp dword[numero],dword 10
 jl _uno          ;numero < 10
    jge _jump1     ; numero >= 10
          _uno:
              mov ecx,3
          jmp _begin_for
 _jump1:
 cmp dword[numero],dword 100
 jl  _dos
     jge _jump2
          _dos:
              mov ecx,2
          jmp _begin_for
 _jump2:
        cmp dword[numero],dword 1000
        jl _tres
            jge _jump3
                _tres:
                      mov ecx,1
 _jump3:
        mov ecx,1
 _begin_for:
        cmp byte[flag_bug],1
        jne _for
            add ecx,1 ;else
  _for:
    push ecx
      print_generic zero,1
    pop ecx
  loop _for
 end_for:
ret
