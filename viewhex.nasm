section .data

    msgwelcome  db      10," +----------------------------------------------------------------+",10
                db         " |################################################################|",10
                db         " |######################Visor hexadecimal Nasm####################|",10
                db         " |################################################################|",10
                db         " +----------------------------------------------------------------+",10
                db         " |                                                                |",10
    lenmsgwelcome equ    $-msgwelcome
    msgend      db       10," +----------------------------------------------------------------+",10
    lenmsgend   equ      $-msgend
    msgerror    db       10,"author: Samuel Loza <starsaminf@gmail.com>"
                db       10,"Funciona con parametros",10,"Ejemplo:"
                db       10,"sam@Scarlet:~$./nombre_ejecutable [archivo]",10
    errorlen    equ      $-msgerror   
    tamano      equ      1000000000
    msguion     db       " - "
    msgnewline  db       10  
    msgspace    db       "_"                                                      ;Remplaces space
    space       db       " "
    aux         db       "0"
    flag        db       0
    separator   db       "  |  "
    separator1  db       " | "
    zero        db       "0"
    numero      dw       0
    numero2     dw       0
    ;HEX
     table  db  "00", "01", "02", "03", "04", "05", "06", "07" 
            db  "08", "09", "0A", "0B", "0C", "0D", "0E", "0F" 
            db  "10", "11", "12", "13", "14", "15", "16", "17" 
            db  "18", "19", "1A", "1B", "1C", "1D", "1E", "1F" 
            db  "20", "21", "22", "23", "24", "25", "26", "27" 
            db  "28", "29", "2A", "2B", "2C", "2D", "2E", "2F" 
            db  "30", "31", "32", "33", "34", "35", "36", "37" 
            db  "38", "39", "3A", "3B", "3C", "3D", "3E", "3F" 
            db  "40", "41", "42", "43", "44", "45", "46", "47" 
            db  "48", "49", "4A", "4B", "4C", "4D", "4E", "4F" 
            db  "50", "51", "52", "53", "54", "55", "56", "57" 
            db  "58", "59", "5A", "5B", "5C", "5D", "5E", "5F" 
            db  "60", "61", "62", "63", "64", "65", "66", "67" 
            db  "68", "69", "6A", "6B", "6C", "6D", "6E", "6F" 
            db  "70", "71", "72", "73", "74", "75", "76", "77" 
            db  "78", "79", "7A", "7B", "7C", "7D", "7E", "7F" 
            db  "80", "81", "82", "83", "84", "85", "86", "87" 
            db  "88", "89", "8A", "8B", "8C", "8D", "8E", "8F" 
            db  "90", "91", "92", "93", "94", "95", "96", "97" 
            db  "98", "99", "9A", "9B", "9C", "9D", "9E", "9F" 
            db  "A0", "A1", "A2", "A3", "A4", "A5", "A6", "A7" 
            db  "A8", "A9", "AA", "AB", "AC", "AD", "AE", "AF" 
            db  "B0", "B1", "B2", "B3", "B4", "B5", "B6", "B7" 
            db  "B8", "B9", "BA", "BB", "BC", "BD", "BE", "BF" 
            db  "C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7"
            db  "C8", "C9", "CA", "CB", "CC", "CD", "CE", "CF" 
            db  "D0", "D1", "D2", "D3", "D4", "D5", "D6", "D7"
            db  "D8", "D9", "DA", "DB", "DC", "DD", "DE", "DF" 
            db  "E0", "E1", "E2", "E3", "E4", "E5", "E6", "E7" 
            db  "E8", "E9", "EA", "EB", "EC", "ED", "EE", "EF" 
            db  "F0", "F1", "F2", "F3", "F4", "F5", "F6", "F7" 
            db  "F8", "F9", "FA", "FB", "FC", "FD", "FE", "FF"
section .bss
    buffer:     resb 1000000000
section .text
    global _start
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msgwelcome
    mov edx,lenmsgwelcome
    int 80h
 ;pop arguments
    pop ebx 
    pop ebx

 ;abrir fichero
    mov eax,5              ; open(
    pop ebx                ; url del archivo
    mov ecx,0              ; read-only mode
    int 80h                ; );
; end abrir

test eax,eax                ; cambia los flags, solo flags
jns leer_del_fichero        ; si !=0 leer archivo si ==0 hubo problemas
    hubo_error: 
        mov eax,4           ; write(
        mov ebx,1           ;   STDOUT,
        mov ecx,msgerror    ;   *buf
        mov edx,errorlen    ; );
        int 80h
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
;    mov eax,4              ;write(
;    mov ebx,1              ; STDOUT,
;    mov ecx,buffer         ; *buf
;    push ecx               ; guardamos en stack 
;    int 80h                ; );
;Separa de 8 en 8 los grupos

;begin KERNEL :S
mov ecx,buffer              ;Guardamos el buffer en ecx, para recorrer como puntero
push ecx                    ;psuh buffer

;I am KERNEL
 comienzo:
    pop ecx                 
    cmp byte[ecx], 0                                                      ;ecx compare 0 => EOF archivo
        je fin                                                            ;si EOF true
          ;begin HEX
          ;imrpirme 8
          ;not byte[flag]
          push ecx                                                        ;save buffer

          cmp byte[flag],1
          je for4                                                         ;if(flag == true) print 0000 - 0007 
            call numerationdec
            mov byte[flag],0                                              ;cambia estado flag                        
          for4:                                                              
              mov byte[flag],1                                            ;cambia estado flag
              pop ecx                                                     ;pop buffer
              ;Rango a imprimir
              mov esi,4                                                  
              for0:
                   ;begin print hex :( old alternative
                      mov eax,4
                      mov ebx,1
                      
                      push ecx                                             ;save buffer
                      
                      movzx edx,byte[ecx]                                  ;transformacion                       
                      mov  ecx,table
                      add  edx,edx                                         ; doblar el tamaño
                      add  ecx,edx                                         ; pointer + int => index
                      mov  edx,2
                      int  80h               
                      
                      ;print space
                          mov eax,4
                          mov ebx,1
                          mov ecx,space
                          mov edx,1
                          int 80h
                      ;end print space
                      
                      pop ecx                                               ;pop buffer
                      inc ecx                                               ;Puntero buffer++
                      dec esi                                               ;rango impirmir--
                      push ecx                                              ;save buffer
                cmp esi,0
                jne for0                                                    ;repite 2 para imprimir los dos rangos
                    cmp byte[aux],'1'
                          je no_guion        
                          mov eax,4
                          mov ebx,1
                          mov ecx,msguion
                          mov edx,3
                          int 80h
          no_guion:
          ; find imprime rango 0000 - 0000
          inc byte[aux]
          cmp byte[aux],'2'
          jne comienzo

          ;Imprime valores originales del archivo
            mov eax,4
            mov ebx,1
            mov ecx,separator
            mov edx,5
            int 80h
          
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
                   ;print 1 character
                    mov eax,4
                    mov ebx,1
                    ; verificar si no es character especial
                        push ecx
                        cmp byte[ecx],10                                     ;si es /n
                         jne conti1 
                                 mov ecx,msgspace
                                 mov edx,1 
                                 int 80h
                                 pop ecx  
                                 inc ecx
                                 dec esi
                                 jmp  for
                   ;end verificar
                    conti1:
                    pop ecx
                    mov edx,1 
                    int 80h
                    inc ecx     
                   ;end character
          dec esi
          jmp for
          guion:                                                                ; cada 8 imprime
            not ebp                                                             ;ebp=!ebp flags
            push ecx                                                            ;save ecx
            mov eax,4
            mov ebx,1

            cmp ebp,0
            je continue
           
            mov ecx,msguion
            mov edx,3
            int 80h  

    continue:
    cmp edi,0
    jnz  comienzo2
  jmp  newline

;begin separa
  newline: 
     mov eax,4
     mov ebx,1
     mov ecx,separator1
     mov edx,3
     int 80h
          ;print endl
            mov eax,4
            mov ebx,1
            mov ecx,msgnewline
            mov edx,1
            int 80h
            mov byte[aux],'0'    
          ;end print endl

mov byte[flag],0                                                                 ;valor inicial
jmp comienzo
;end separa
;END KERNEL
; fin
fin:
mov eax,4
mov ebx,1
mov ecx,msgend
mov edx,lenmsgend
int 80h
mov ebx,0
mov eax,1
int 80h
;_____________________________________________________________-
;print numeration dec
numerationdec:
     ;print first number
     mov eax,4
     mov ebx,1
     mov ecx,separator1
     mov edx,4
     int 80h
     cmp dword[numero] ,10
     jl onedigit              ;1<10  true salta
     cmp dword[numero],100    ;50 < 100 true salta
     jl twodigit
     cmp dword[numero],1000   ;950 < 1000
     jl thredigit
     jmp fourdigit

     onedigit:
      mov ecx,2
      call print_dec
      jmp _gui
     twodigit:
      mov ecx,2
      call print_dec
      jmp _gui
     thredigit:
      mov ecx,2
      call print_dec
      jmp _gui
     fourdigit:
      mov ecx,1
      call print_dec
      jmp _gui
    ;end first number
    
    ;print guion
    _gui:
    add dword[numero],8
    mov eax,4
    mov bx,1
    mov ecx,msguion
    mov edx,3
    int 80h
    ;end print guion

    ;second number
     cmp dword[numero] ,10
     jl onedigit0       ;1<10  true salta
     cmp dword[numero],100 ;50 < 100 true salta
     jl twodigit0
     cmp dword[numero],1000  ;950 < 1000
     jl thredigit0
     jmp fourdigit0

     onedigit0:
      mov ecx,3
      call print_dec
      jmp _sec
     twodigit0:
      mov ecx,3
      call print_dec
      jmp _sec
     thredigit0:
      mov ecx,3
      call print_dec
      jmp _sec
     fourdigit0:
      mov ecx,2
      call print_dec
      jmp _sec   
    ;end second number
   ;print space
    _sec:
    add dword[numero],1
    mov eax,4
    mov ebx,1
    mov ecx,separator
    mov edx,5
    int 80h
   ;end space
ret
;end print numeration


print_dec:
    cmp ecx,0
    je salto
  _for:
    push ecx
    mov eax,4
    mov ebx,1
    mov ecx,zero
    mov edx,1
    int 80h
    pop ecx
  loop _for
  ;transforma numero
  salto:
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
  ;end transforma numero

  ;print number
  mov eax,4
  mov ebx,1
  mov ecx,numero2
  mov edx,5
  int 80h
ret

print_hex:

ret
