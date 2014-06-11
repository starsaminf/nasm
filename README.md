Materia Assembler NASM
====
1.- Preparando el campo de batalla IDE
    Yo uso Sublimtext 3 megusta mucho :D
    Tener instaldo en Linux preferentemente :D
====
# Sublime-NASM
_Intel x86 NASM_ syntax highlighting for _Sublime Text_.

## Installation
Navigate with Terminal in your `Packages` folder and type

	git clone https://github.com/SalvoGentile/Sublime-NASM.git

## Credits
This package is based on the [Assembly-x86](https://github.com/ljgago/Assembly-x86) package from [Leonardo Gago](https://github.com/ljgago).

## Script compilacion
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
###New Build System
```
{
	"cmd": ["/opt/scrpt_sublime/Run_nasm.sh ${file_name} ${file_base_name}"],
    "shell": true
}
```


