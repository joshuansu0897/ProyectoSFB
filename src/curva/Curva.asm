section .text
Curva:

    call validarArray

    mov eax, [esi+ebp*4] ; Movemos un numero a eax
    call OperacionCurva  ; se hace la operacion aritmetica
    mov [esp+ebp*4], eax ; el resultado se mueve al arreglo esp
    inc ebp              ; incrementa ebp
    dec edi              ; se decrementa
    cmp edi, 0           ; comparamos con 0
    jnz Curva            ; si no es iwal a 0 se regresa a curva

    call lentArrayNormal ; movemos el valor de ebp a

    call messageOperacion

    jmp main             ; regresando al principio
