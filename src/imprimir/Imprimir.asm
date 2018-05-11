section .data
    labelArregloEntrada DB 'Arreglo de entrada',0x0
    labelArregloResultados DB 'Arreglo de resultados',0x0
    labelIgualEntrada DB '==================',0x0
    labelIgualResultados DB '=====================',0x0
    espaciosLabel DB 9,0x0
    espaciosNumeros DB 9,9,9,0x0

section .text
imprimirArreglos:

    mov eax, labelArregloEntrada    ; movemos el label a eax
    call sprint                     ; imprimimos el label

    mov eax, espaciosLabel          ; movemos el label a eax
    call sprint                     ; imprimimos el label

    mov eax, labelArregloResultados ; movemos el label a eax
    call sprintLF                   ; imprimimos el label con salto de linea

    mov eax, labelIgualEntrada      ; movemos el label a eax
    call sprint                     ; imprimimos el label

    mov eax, espaciosLabel          ; movemos el label a eax
    call sprint                     ; imprimimos el label

    mov eax, labelIgualResultados   ; movemos el label a eax
    call sprintLF                   ; imprimimos el label con salto de linea

    mov eax, espaciosLabel          ; movemos el label a eax
    call sprint                     ; imprimimos el label

cicloArreglos:
    mov eax, [esi+ebp*4]            ; Movemos un numero a eax
    call iprint                     ; Imprimimos el numero
    mov eax, espaciosNumeros        ; movemos el label a eax
    call sprint                     ; imprimimos el label
    mov eax, [esp+ebp*4]            ; movemos el numero resultado al array esp
    call iprintLF                   ; imprimimos label con salto de linea
    call numeroMayor                ; buscamos el numero mayor
    call numeroMenor                ; buscamos el numero menor
    mov eax, espaciosLabel          ; movemos el label a eax
    call sprint                     ; imprimimos el label
    inc ebp                         ; incrementamos ebp
    dec edi                         ; decrementamos edi
    cmp edi, 0                      ; comparamos edi con 0
    jnz cicloArreglos               ; si no es cero regresamos a cicloArreglos

    call lentArrayNormal            ; cambia el valor de ebp a edi

    call saltoDeLinea               ; salto de linea

    call printMayorMenor            ; imprimimos los numeros, mayor y menor

    jmp main
