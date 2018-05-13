section .data
    LabelSave DB ' El archivo se guardo perfectamente ',0x0
    LabelOperacion DB ' La operacion se llevo acabo perfectamente ',0x0
    LabelAgrego DB ' El valor se agrego perfectamente ',0x0

section .text
messageDatoAgregado:        ; salida de mensaje
    call decoracionVerde    ; imprimimos la decoracionVerde
    mov eax, LabelAgrego    ; cargamos el primer mensaje
    call sprint             ; mandamos a llamar al "metodo" que imprime
    call decoracionVerde    ; imprimimos la decoracionVerde
    call saltoDeLinea
    call saltoDeLinea
    ret

messageSave:                ; salida de mensaje
    call decoracionVerde    ; imprimimos la decoracionVerde
    mov eax, LabelSave      ; cargamos el primer mensaje
    call sprint             ; mandamos a llamar al "metodo" que imprime
    call decoracionVerde    ; imprimimos la decoracionVerde
    call saltoDeLinea
    call saltoDeLinea
    ret

messageOperacion:           ; salida de mensaje
    call decoracionVerde    ; imprimimos la decoracionVerde
    mov eax, LabelOperacion ; cargamos el primer mensaje
    call sprint             ; mandamos a llamar al "metodo" que imprime
    call decoracionVerde    ; imprimimos la decoracionVerde
    call saltoDeLinea
    call saltoDeLinea
    ret
