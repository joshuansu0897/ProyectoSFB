segment .bss
    array_res RESB 400                                ; buffer para alumno
    len_array_res EQU $-array_res                     ; lent del buffer

    filename RESB 30                                  ; buffer para filename
    len_filename EQU $-filename                       ; lent del filename

    archivo RESB 30

section .data
    p_archivo DB "¿Nombre de archivo a guardar?>",0x0 ; mensaje archivo

section .text
Guardar:
    mov ebx, array_res                                ; movemos el array(buffer) a ebx
    mov edx, 0                                        ; movemos 0 a edx

    ;;;call printArrEsi ; aqui esta bien todo el array de esi

.cicloArreglos:
    mov eax, [esi+ebp*4]                              ; Movemos un numero a eax
    push esi                                          ; guardamos el array de esi
    call itoa                                         ; convertimos int a str
    mov eax, esi                                      ; movemos el str a eax
    pop esi                                           ; sacamos el array del stack

.sigcarEsi:                                           ; esto es para tomar todos los char del primer arg de esi
    mov cl, byte[eax]                                 ; movemos el byte a cl
    cmp cl, 0x0                                       ; comparamos con 0x0 para saber si ya se acabo
    je .nextEsp                                       ; si se acabo vamos al siguiente de Esp (array resultados)
    mov byte[ebx+edx], cl                             ; movemos el byte a ebx (array_res)
    inc edx                                           ; decrementamos edx
    inc eax                                           ; incrementamos eax, para tomar el otro byte
    jmp .sigcarEsi                                    ; regresamos

.nextEsp:                                             ; toma el siguiente argumento de esp (array resultados)
    mov cl, 0x2C                                      ; movemos una ',' para separar los numeros
    mov byte[ebx+edx], cl                             ; movemos la coma al bufer
    inc edx                                           ; incrementamos edx
    mov eax, [esp+ebp*4]                              ; Movemos un numero a eax
    push esi                                          ; guardamos el array de esi
    call itoa                                         ; convertimos int a str
    mov eax, esi                                      ; movemos el str a eax
    pop esi                                           ; sacamos el array del stack

.sigcarEsp:                                           ; esto es para los chars de los args de esp
    mov cl, byte[eax]                                 ; sacamos el byte del argumento
    cmp cl, 0x0                                       ; comparamos con 0x0 para saber si se acabo
    je .next                                          ; si se acabo, camos al siguiente indice de los arrays
    mov byte[ebx+edx], cl                             ; movemos el byte al bufer
    inc edx                                           ; incrementamos edx, para escribir en la siguiente posicion
    inc eax                                           ; incrementamos eax, para tomar el otro byte
    jmp .sigcarEsp                                    ; regresamos

.next:                                                ; para el siguiente indice de los arrays
    mov cl, 0xA                                       ; un salto de linea para los siguientes args
    mov byte[ebx+edx], cl                             ; no se que pedo
    inc edx                                           ; incrementamos edx
    inc ebp                                           ; incrementamos ebp
    dec edi                                           ; decrementamos edi
    cmp edi, 0                                        ; comparamos edi con 0
    jnz .cicloArreglos                                ; si no es cero regresamos a cicloArreglos

    call lentArrayNormal                              ; cambia el valor de ebp a edi

    ;;;call printArrEsi ; para este punto esi ya esta modificado en su posicion 0, no se porque

    mov eax, p_archivo                                ; pregunta por nombre de archivo a guardar
    call sprint                                       ; imprime mensaje

    mov ecx, filename                                 ; captura filename
    mov edx, len_filename                             ; con longitud maxima de len:filename

    call LeerTexto                                    ; input desde el teclado

    call saltoDeLinea

    push esi                                          ; guardamos el valor de esi (array)

    mov esi, archivo                                  ; copia hasta archivo
    mov eax, filename                                 ; desde filename
    call copystring                                   ; pero sin el caracter 0xA

    pop esi                                           ; restauramos el valor de esi (array)

    mov eax, sys_creat                                ; sys_creat EQU 8
    mov ebx, archivo                                  ; nombre del archivo
    mov ecx, 664o                                     ; los permisos

    int 0x80                                          ; llamada al kernel

    cmp eax, 0
    jle errorSaveFile                                 ; si es 0 o menos error al crear

    mov eax, sys_open                                 ; abrir archivo
    mov ebx, archivo                                  ; nombre del archivo que esta en la var archivo
    mov ecx, O_RDWR                                   ; abrimos en modo de lectura y escritura
    int 0x80                                          ; ejecutar
    cmp eax, 0
    jle errorOpenFile                                 ; si es 0 o menos error al abrir

    mov ebx, eax                                      ; file hanldre to ebx

    mov eax, sys_write
    mov ecx, array_res
    mov edx, len_array_res
    int 0x80
    mov eax, sys_sync                                 ; sincroniza discos (forzar escritura)
    int 0x80

    mov eax, sys_close                                ; close file
    int 0x80

    call messageSave

    jmp main
