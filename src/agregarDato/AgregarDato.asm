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

    jmp main                          ; regresando al principio
