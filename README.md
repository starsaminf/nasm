Materia Assembler NASM INFORMATICA - UMSA
starsaminf.blogspot.com
inf-121-lab.blogspot.com
====
Preparando campo de Batalla IDE SU	
====

## Installation highlighting for _Sublime Text_. :D
cd /home/sam/.config/sublime-text-3/Packages/User/
git clone https://github.com/SalvoGentile/Sublime-NASM.git
Cambiar segun la ruta de sublime
## Script compilacion
Para no estar a cada rato compilando y ejecuntando mejor este bonito script :D
Para ejecutarlo en SublimText ctrol + B
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


