section .text
Lineal:
    mov eax, [esi+ebp*4]              ; Movemos un numero a eax
    call OperacionLineal              ; Imprimimos el numero
    mov [esp+ebp*4], eax              ; movemos el numero resultado al array esp
    inc ebp
    dec edi
    cmp edi, 0
    jnz Lineal

    call lentArrayNormal

    jmp main                          ; regresando al principio
