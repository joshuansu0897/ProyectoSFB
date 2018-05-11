%include './Utils/funciones_basicas.asm'
%include './Utils/Operaciones.asm'
%include './menu/Menu.asm'
%include './leerArgumento/LeerArgumento.asm'
%include './agregarDato/AgregarDato.asm'
%include './error/Error.asm'
%include './curva/Curva.asm'
%include './linea/Linea.asm'
%include './imprimir/Imprimir.asm'

section .bss
    arreglo_entero resb 200              ; 50 casillas de 4 bytes c/u
    arreglo_result resb 200              ; 50 casillas de 4 bytes c/u

section .text
    global _start:                       ; declaramos punto de inicio

_start:
    mov esi, arreglo_entero              ; movemos el arreglo a esi
    jmp argumentoArchivo                 ; vamos a leer el archvio que va en el argumento

main:                                    ; ciclo para el menu
    call printMenu                       ; imprimimos el menu

    cmp eax, 0                           ; comparamos con la opcion 0, para salir
    je quit

    cmp eax, 1                           ; comparamos con la opcion 1, para agregar numero
    je AgregarNumero

    cmp eax, 2                           ; comparamos eax con 2
    je Lineal                            ; si eax es iwal a 2 vamos a la funcion lineal

    cmp eax, 3                           ; comparamos eax con la opcion 3
    je Curva                             ; si es igual a 3 vamos a la funcion curva

    cmp eax, 4                           ; comparamos eax con 4
    je imprimirArreglos                  ; si es igual vamos a imprimir

    cmp eax, 5
    je quit                              ; aqui va guardar en archivo

    cmp eax, 5                           ; si es mayor a 5, manda el error de opcion
    jg errorOpcion
