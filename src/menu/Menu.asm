section .data
    opcion1 DB '*** MENU ***',0xA,0x0
    opcion2 DB '1. Agregar Dato',0xA,0x0
    opcion3 DB '2. Generar Linea',0xA,0x0
    opcion4 DB '3. Generar Curva',0xA,0x0
    opcion5 DB '4. Mostrar Datos (Imprimir)',0xA,0x0
    opcion6 DB '5. Guardar archivo',0xA,0x0
    opcion7 DB '0. Salir',0xA,0x0
    opcion8 DB 'Opcion>',0x0

section .bss
    Buffer_opcion resb 20
    Buffer_opcion_len equ $-Buffer_opcion

section .text
printMenu:
    mov eax, opcion1           ; cargamos el primer mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime

    call saltoDeLinea          ; nada mas es un salto de linea

    mov eax, opcion2           ; cargamos el segundo mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime
    mov eax, opcion3           ; cargamos el tercer mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime
    mov eax, opcion4           ; cargamos el cuarto mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime
    mov eax, opcion5           ; cargamos el quinto mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime
    mov eax, opcion6           ; cargamos el sexto mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime
    mov eax, opcion7           ; cargamos el septimo mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime

    call saltoDeLinea          ; nada mas es un salto de linea

    mov eax, opcion8           ; cargamos el octavo mensaje
    call sprint                ; mandamos a llamar al "metodo" que imprime

    mov ecx, Buffer_opcion     ; direccion de Buffer a ecx
    mov edx, Buffer_opcion_len ; longitud del Buffer_len a edx
    call LeerTexto             ; llamamos la funcion LeerTexto

    mov eax, Buffer_opcion     ; preparamos para convertir edad
    call atoi                  ; convertimos

    call saltoDeLinea          ; salto de linea para que se vea mas estetico

    ret
