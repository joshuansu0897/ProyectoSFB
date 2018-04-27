%include './Utils/funciones_basicas.asm'
%include './menu/menu.asm'
%include './leerArgumento/leerArgumento.asm'
%include './agregarDato/agregarDato.asm'
%include './error/error.asm'

section .text
    global _start:        ; declaramos punto de inicio

_start:
    jmp argumentoArchivo

main:
    call printMenu

    cmp eax, 0
    je quit

    cmp eax, 1
    je AgregarNumero

    cmp eax, 5
    jg errorOpcion
