section .data
    setcolorVerde db 1Bh, '[32;1m', 0 ; color verde sin fondo (32 color; 1 el fondo )
        .len equ $ - setcolorVerde

    setcolorRojo db 1Bh, '[31;1m', 0  ; color rojo sin fondo (31 color; 1 el fondo )
        .len equ $ - setcolorRojo

    setcolorAzul db 1Bh, '[34;1m', 0  ; color rojo sin fondo (34 color; 1 el fondo )
        .len equ $ - setcolorAzul

    setcolorNormal db 1Bh, '[0;0m', 0 ; regresa a la normalidad (0 reset; 0 reset )
        .len equ $ - setcolorNormal

    decoracion DB '***',0x0

section .text
ColorVerde:
    mov eax, 4
    mov ebx, 1
    mov ecx, setcolorVerde
    mov edx, setcolorVerde.len
    int 80h
    ret

ColorAzul:
    mov eax, 4
    mov ebx, 1
    mov ecx, setcolorAzul
    mov edx, setcolorAzul.len
    int 80h
    ret

ColorRojo:
    mov eax, 4
    mov ebx, 1
    mov ecx, setcolorRojo
    mov edx, setcolorRojo.len
    int 80h
    ret

ColorNormal:
    mov eax, 4
    mov ebx, 1
    mov ecx, setcolorNormal
    mov edx, setcolorNormal.len
    int 80h
    ret

decoracionVerde:
    push eax
    call ColorVerde
    mov eax, decoracion
    call sprint
    call ColorNormal
    pop eax
    ret

decoracionAzul:
    push eax
    call ColorAzul
    mov eax, decoracion
    call sprint
    call ColorNormal
    pop eax
    ret

decoracionRoja:
    push eax
    call ColorRojo
    mov eax, decoracion
    call sprint
    call ColorNormal
    pop eax
    ret
