Materia Assembler NASM INFORMATICA - UMSA
```
starsaminf.blogspot.com
inf-121-lab.blogspot.com
```
====
Preparando campo de Batalla IDE SU	
====

## Installation highlighting for _Sublime Text_. :D
```
cd /home/sam/.config/sublime-text-3/Packages/User/
git clone https://github.com/SalvoGentile/Sublime-NASM.git
```
Cambiar segun la ruta de sublime
## Script compilacion
Para no estar a cada rato compilando y ejecuntando mejor este bonito script :D
Para ejecutarlo en SublimText ctrl + B
Run_nasm.sh
```
#!/bin/bash
gnome-terminal -e "/bin/bash -c '
nasm -f elf32 $1;
ld -s -o $2 $2.o;
./$2 /opt/nasm/tarea_cat/test.txt; echo;
read -p 'Intro_para_salir...';
exit;
exec /bin/bash';
 &"
```
chmod +x Run_nasm.sh
###New Build System
Sublim Text - >  Tools --> Build System --> New Build System
```
{
    "cmd": ["/opt/scrpt_sublime/Run_nasm.sh ${file_name} ${file_base_name}"],
    "shell": true
}
```
###movzx###
MOVZX 指令
 
Variantes instrucción de transferencia de datos en lenguaje ensamblador MOV. Sin extensión de signo, y enviar.
movzx es copiar el contenido del operando fuente al operando destino, y el valor 0 se extendió a 16 o 32. Pero sólo se aplica a un número entero sin signo. Él más o menos la siguiente tres formatos.
　　movzx 32 bits registros de propósito general, los ocho registros de propósito general / unidad de memoria
　　movzx 32 bits registros de propósito general de 16 bits registros de propósito general / unidad de memoria
　　movzx 16 bits registros de propósito general, los ocho registros de propósito general / unidad de memoria
　　Para dar un ejemplo. Por ejemplo
　　令 eax = 00304000h
　　Si ejecuta eax movzx, hacha después eax = 00004000h.
　　Si ejecuta después eax movzx, ah eax = 00000040h.
　　Otro ejemplo:
　　BL MOV, 80H
　　MOVZX AX, BL
　　Después de ejecutar la compilación de la sentencia anterior, AX valor 0080H. Debido BL es 80H, el bit más alto que es el bit de signo es 1, pero sin hacer extensión de signo, la extensión de la alta-8 son iguales a cero, por lo que el AX asignación es 0080H.
　　Resumen:
　　movzx hecho, nuestro operando fuente sacado, y luego se coloca en el operando destino, el operando destino trozos llenos de ceros restantes.


