section .data
    LabelOpcionError DB '*** Esa Opcion No Es Valida ***',0x0
    LabelSalidaError DB '*** ERROR AL ABRIR ARCHIVO ***',0x0
    LabelSaveError DB '*** ERROR AL GUARDAR EL ARCHIVO ***',0x0

section .text
errorOpcion:
    mov eax, LabelOpcionError ; cargamos el primer mensaje
    call sprintLF             ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea
    jmp main                  ; regresando al principio

errorOpenFile:                ; salida de error
    mov eax, LabelSalidaError ; cargamos el primer mensaje
    call sprintLF             ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea
    jmp main                  ; regresando al principio

errorSaveFile:                ; salida de error
    mov eax, LabelSaveError   ; cargamos el primer mensaje
    call sprintLF             ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea
    jmp main                  ; regresando al principio
