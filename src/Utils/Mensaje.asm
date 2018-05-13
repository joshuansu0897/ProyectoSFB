section .data
    LabelSave DB '*** El archivo se guardo perfectamente ***',0x0
    LabelOperacion DB '*** El operacion se llevo acabo perfectamente ***',0x0

section .text
messageSave:                ; salida de mensaje
    mov eax, LabelSave      ; cargamos el primer mensaje
    call sprintLF           ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea
    ret

messageOperacion:           ; salida de mensaje
    mov eax, LabelOperacion ; cargamos el primer mensaje
    call sprintLF           ; mandamos a llamar al "metodo" que imprime
    call saltoDeLinea
    ret
