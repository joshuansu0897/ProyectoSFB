section .data
    LabelAgregarNumero DB 'Número entero>',0x0

section .bss
    Buffer_AgregarNumero resb 20
    Buffer_AgregarNumero_len equ $-Buffer_AgregarNumero

section .text
AgregarNumero:
    mov eax, LabelAgregarNumero       ; cargamos el primer mensaje
    call sprint                       ; mandamos a llamar al "metodo" que imprime

    mov ecx, Buffer_AgregarNumero     ; direccion de Buffer a ecx
    mov edx, Buffer_AgregarNumero_len ; longitud del Buffer_len a edx
    call LeerTexto                    ; llamamos la funcion LeerTexto

    mov eax, Buffer_AgregarNumero     ; preparamos para convertir edad
    call atoi                         ; convertimos
    mov [esi+edi*4], eax              ; Movemos a la posiciòn que quedo disponible del arreglo
    inc edi                           ; Incrementamos la posiciòn del arreglo
    call saltoDeLinea

printArrr:
    mov eax, [esi+ebp*4]              ; Movemos un numero a eax
    call iprintLF                     ; Imprimimos el numero
    call OperacionCruva
    call iprintLF
    call numeroMayor
    call numeroMenor
    call saltoDeLinea
    inc ebp
    dec edi
    cmp edi, 0
    jnz printArrr

    mov eax, ebx
    call iprintLF

    mov eax, ecx
    call iprintLF

    call saltoDeLinea

    call lentArrayNormal

    jmp main                          ; regresando al principio
