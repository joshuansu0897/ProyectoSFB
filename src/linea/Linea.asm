section .text
Lineal:
    mov eax, [esi+ebp*4] ; Movemos un numero a eax
    call OperacionLineal ; se hace la operacion aritmetica
    mov [esp+ebp*4], eax ; movemos el numero resultado al array esp
    inc ebp              ; incrementamos ebp
    dec edi              ; decrementamos edi
    cmp edi, 0           ; comparamos con 0
    jnz Lineal           ; si no es iwal edi a 0 se regresa a Lineal

    call lentArrayNormal ; cambia el valor de ebp y edi

    jmp main             ; regresando al principio
