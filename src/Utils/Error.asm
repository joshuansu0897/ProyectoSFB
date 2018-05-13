section .data
    LabelOpcionError DB ' Esa Opcion No Es Valida ',0x0
    LabelSalidaError DB ' ERROR AL ABRIR ARCHIVO ',0x0
    LabelSaveError DB ' ERROR AL GUARDAR EL ARCHIVO ',0x0

section .text
errorOpcion:
    call decoracionRoja       ; imprimimos la decoracionRoja
    mov eax, LabelOpcionError ; cargamos el primer mensaje
    call sprint               ; mandamos a llamar al "metodo" que imprime
    call decoracionRoja       ; imprimimos la decoracionRoja
    call saltoDeLinea
    call saltoDeLinea
    jmp main                  ; regresando al principio

errorOpenFile:                ; salida de error
    call decoracionRoja       ; imprimimos la decoracionRoja
    mov eax, LabelSalidaError ; cargamos el primer mensaje
    call sprint               ; mandamos a llamar al "metodo" que imprime
    call decoracionRoja       ; imprimimos la decoracionRoja
    call saltoDeLinea
    call saltoDeLinea
    jmp main                  ; regresando al principio

errorSaveFile:                ; salida de error
    call decoracionRoja       ; imprimimos la decoracionRoja
    mov eax, LabelSaveError   ; cargamos el primer mensaje
    call sprint               ; mandamos a llamar al "metodo" que imprime
    call decoracionRoja       ; imprimimos la decoracionRoja
    call saltoDeLinea
    call saltoDeLinea
    jmp main                  ; regresando al principio
