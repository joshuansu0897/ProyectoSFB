section .text
Curva:
    mov eax, [esi+ebp*4]              ; Movemos un numero a eax
    call OperacionCurva               ; Imprimimos el numero
    mov [esp+ebp*4], eax              ; movemos el numero resultado al array esp
    inc ebp
    dec edi
    cmp edi, 0
    jnz Curva

    call lentArrayNormal

    jmp main                          ; regresando al principio
