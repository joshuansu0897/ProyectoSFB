# Proyecto Software Base

se necesitan estas extenciones en **Atom** para poder trabajar de forma eficiente
- [save-autorun](https://atom.io/packages/save-autorun)
- [language-x86-64-assembly](https://atom.io/packages/language-x86-64-assembly)

## Ejemplo de uso
Solo necesitas ejecutar en la raiz del proyecto
```bash
./run
```
o
```bash
bash run
```
despues de eso saldra un output asi
```bash

-----------------------------------
  Compilando con nasm
-----------------------------------

-----------------------------------
  Compilado Correcto.
-----------------------------------

-----------------------------------
  Compilando con ld 64bits
-----------------------------------

-----------------------------------
  Compilado Correcto.
-----------------------------------

-----------------------------------
  Corriendo...
-----------------------------------

*** MENU ***
1. Agregar Dato
2. Generar Linea
3. Generar Curva
4. Mostrar Datos (Imprimir)
5. Guardar archivo
0. Salir

Opcion>
```
si prefieres compilarlo manualmente, necesitas ir a la carpeta ```src``` y ejecutar lo sigiente

para compilar en 64bits linux
```bash
nasm -f elf Main.asm
ld -m elf_i386 -s -o Main.sh Main.o
```

para 32bits linux
```bash
nasm -f elf Main.asm
ld -o Main.sh Main.o
```

y para su ejecucion *dentro de ```src```* es
```bash
./Main.sh
```
y si quieres pasar un archivo con los datos del array
seria asi
```bash
./Main.sh texto.txt
```

ejemplo de archivo:
```
4
7
10
```

**Nota:** *ya existe un archivo llamado ```texto.txt``` con numeros, puedes usar ese*
