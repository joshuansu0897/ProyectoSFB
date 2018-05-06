%include './Utils/funciones_basicas.asm'
%include './menu/menu.asm'
%include './leerArgumento/leerArgumento.asm'
%include './agregarDato/agregarDato.asm'
%include './error/error.asm'

section .bss
    arreglo_entero resb 200              ; 50 casillas de 4 bytes c/u
    arreglo_result resb 200              ; 50 casillas de 4 bytes c/u

section .text
    global _start:                       ; declaramos punto de inicio

_start:
    jmp argumentoArchivo                 ; vamos a leer el archvio que va en el argumento

main:                                    ; ciclo para el menu
    call printMenu                       ; imprimimos el menu

    cmp eax, 0                           ; comparamos con la opcion 0, para salir
    je quit

    cmp eax, 1                           ; comparamos con la opcion 1, para agregar numero
    je AgregarNumero

    cmp eax, 5                           ; si es mayor a 5, manda el error de opcion
    jg errorOpcion
