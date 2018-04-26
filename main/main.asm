
%include './Utils/funciones_basicas.asm'
%include './menu/menu.asm'
%include './agregarDato/agregarDato.asm'
%include './error/error.asm'

section .text
    GLOBAL _start     ; declaramos punto de inicio

_start:
    call printMenu

    cmp eax, 0
    je quit

    cmp eax, 1
    je printLabelAgregarNumero

    cmp eax, 5
    jg printErrorLabel
