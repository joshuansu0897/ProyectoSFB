section .data
    LabelError DB '*** Esa Opcion No Es Valida ***',0x0

section .text
printErrorLabel:
    mov eax, LabelError ; cargamos el primer mensaje
    call sprintLF       ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea   ; 
    jmp _start          ; regresando al principio
