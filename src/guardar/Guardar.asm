segment .bss
    array_res RESB 600                   ; buffer para alumno
    len_array_res EQU $-array_res           ; lent del buffer

    filename RESB 30                         ; buffer para filename
    len_filename EQU $-filename              ; lent del filename

    archivo RESB 30

section .data
    p_archivo DB "¿Nombre de archivo a guardar?>",0x0   ; mensaje archivo

section .text
Guardar:
    mov ebx, array_res
    mov edx, 0                      ; movemos 0 a edx

.cicloArreglos:
    mov eax, [esi+ebp*4]            ; Movemos un numero a eax
    push esi                        ; guardamos el array de esi
    call itoa                       ; convertimos int a str
    mov eax, esi                    ; movemos el str a eax
    pop esi                         ; sacamos el array del stack

.sigcarEsi:
    mov cl, byte[eax]
    cmp cl, 0x0
    je .nextEsp
    mov byte[ebx+edx], cl              ; no se que pedo
    inc edx
    inc eax
    jmp .sigcarEsi

.nextEsp:
    mov cl, 0x2C
    mov byte[ebx+edx], cl              ; no se que pedo
    inc edx
    mov eax, [esp+ebp*4]            ; Movemos un numero a eax
    push esi                        ; guardamos el array de esi
    call itoa                       ; convertimos int a str
    mov eax, esi                    ; movemos el str a eax
    pop esi                         ; sacamos el array del stack

.sigcarEsp:
    mov cl, byte[eax]
    cmp cl, 0x0
    je .next
    mov byte[ebx+edx], cl              ; no se que pedo
    inc edx
    inc eax
    jmp .sigcarEsp

.next:
    mov cl, 0xA
    mov byte[ebx+edx], cl              ; no se que pedo
    inc edx
    inc ebp                         ; incrementamos ebp
    dec edi                         ; decrementamos edi
    cmp edi, 0                      ; comparamos edi con 0
    jnz .cicloArreglos              ; si no es cero regresamos a cicloArreglos

    call lentArrayNormal            ; cambia el valor de ebp a edi

    mov eax, p_archivo                       ; pregunta por nombre de archivo a guardar
    call sprint                              ; imprime mensaje

    mov ecx, filename                        ; captura filename
    mov edx, len_filename                    ; con longitud maxima de len:filename

    call LeerTexto                           ; input desde el teclado

    call saltoDeLinea

    mov esi, archivo                         ; copia hasta archivo
    mov eax, filename                        ; desde filename
    call copystring                          ; pero sin el caracter 0xA

    mov eax, sys_creat                       ; sys_creat EQU 8
    mov ebx, archivo                         ; nombre del archivo
    mov ecx, 664o                            ; los permisos

    int 0x80                                 ; llamada al kernel

    cmp eax, 0
    jle errorSaveFile                        ; si es 0 o menos error al crear

    mov eax, sys_open                        ; abrir archivo
    mov ebx, archivo                         ; nombre del archivo que esta en la var archivo
    mov ecx, O_RDWR                          ; abrimos en modo de lectura y escritura
    int 0x80                                 ; ejecutar
    cmp eax, 0
    jle errorOpenFile                        ; si es 0 o menos error al abrir

    mov ebx, eax                             ; file hanldre to ebx

    mov eax, sys_write
    mov ecx, array_res
    mov edx, len_array_res
    int 0x80
    mov eax, sys_sync                        ; sincroniza discos (forzar escritura)
    int 0x80

    mov eax, sys_close                       ; close file
    int 0x80

    call messageSave

    jmp main
