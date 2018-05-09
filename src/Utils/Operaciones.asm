section .text
OperacionLineal:
    push edx               ; guardamos edx

    mov edx, 4
    imul edx               ; multiplicamos eax = eax * edx
    add eax, 3             ; sumamos 3

    pop edx                ; regresamos el valor de edx
    ret

OperacionCruva:
    push edx               ; guardamos edx
    push ebx               ; guardamos ebx
    push ecx               ; guardamos ecx

    mov ecx, 0             ; movemos 0 a ecx

    mov ebx, eax           ; movemos el numero original a ebx

    imul ebx               ; x * x   = x^2
    imul ebx               ; x^2 * x = x^3

    add ecx, eax           ; agregamos el valor de eax a ecx

    mov eax, ebx           ; movemos X a eax

    imul ebx               ; X * X = X^2

    mov edx, 4             ; movemos 4 a edx
    imul edx               ; eax * 4

    sub ecx, eax           ; restamos el valor de eax a ecx

    mov eax, ebx           ; movemos X a eax

    mov edx, 6             ; movemos 4 a edx
    imul edx               ; eax * 4

    add ecx, eax           ; agregamos el valor de eax a ecx

    mov eax, 24            ; movemos 24 a edx
    sub ecx, eax           ; restamos 24

    mov eax, ecx           ; movemos a eax el valor de ecx

    pop ecx                ; regresamos el valor de ecx
    pop ebx                ; regresamos el valor de ebx
    pop edx                ; regresamos el valor de edx
    ret
