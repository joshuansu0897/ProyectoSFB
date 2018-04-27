section .data
    LabelAgregarNumero DB 'Número entero>',0x0

section .text
printLabelAgregarNumero:
    mov eax, LabelAgregarNumero ; cargamos el primer mensaje
    call sprint                 ; mandamos a llamar al "metodo" que imprime
    ; logica
    call saltoDeLinea           ;
    jmp _start                  ; regresando al principio
