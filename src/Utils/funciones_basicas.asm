; funciones.asm
section .data
    sys_exit  equ   1
    sys_read  equ   3
    sys_write equ   4
    sys_open  equ   5        ; apertura de archivo
    sys_close equ   6        ; cierre de archivo
    sys_creat equ   8        ; crear archivo
    sys_sync  equ  36        ; sincronizar con disco (forzar escritura)
    stdin     equ   0        ; entrada estandar (teclado)
    stdout    equ   1        ; salida estandar (pantalla)
    stderr    equ   3        ; salida de error estandar
    O_RDONLY  equ   0        ; open for read only
    O_RDWR    equ   1        ; open for read and write.
    saltoLinea DB '',0x0
    LabelMayor DB 'El número mayor es:',0x0
    LabelMenor DB 'El número menor es:',0x0

section .bss
    letra   resb    2

section .text

validarArray:
    cmp edi, 0                      ; validamos que tenga algo el array
    jz errorArrayVacio              ; si esta vacio vamos hacia alla
    ret
    
printArrEsi:
    mov eax, [esi+ebp*4] ; Movemos un numero a eax
    call iprintLF
    inc ebp              ; incrementa ebp
    dec edi              ; se decrementa
    cmp edi, 0           ; comparamos con 0
    jnz printArrEsi      ; si no es iwal a 0 se regresa a curva

    call lentArrayNormal

    call saltoDeLinea

    ret

printMayorMenor:
    push eax                 ; guardamos el valor de eax
    push edx                 ; guardamos el numero mayor en el stack
    push ecx                 ; guardamos el numero menor en el stack

    mov eax, LabelMenor      ; movemos label a eax
    call sprint              ; imprimimos
    call ColorRojo           ; lo siguiente que escribas sera rojo
    pop eax                  ; sacamos el numero menor del stack
    call iprintLF            ; imprimimos con salto de linea
    call ColorNormal         ; regresaamos los colores a la normalidad
    mov eax, LabelMayor      ; movemos el label a eax
    call sprint              ; imprimimos
    call ColorVerde          ; lo siguiente que escribas sera verde
    pop eax                  ; saacamos el numero mayor del stack
    call iprintLF            ; imprimimos con salto de linea
    call ColorNormal         ; colores a la normalidad

    call saltoDeLinea

    pop eax                  ; tomamos el valor de eax
    ret

lentArrayNormal:             ; este metodo es para mover el valor de edp a edi
    cmp ebp, 0               ; comparamos
    jnz lentArrayNormalCiclo ; si es diferente de 0
    ret

lentArrayNormalCiclo:
    dec ebp                  ; retamos edp
    inc edi                  ; incrementamos edi
    jmp lentArrayNormal      ; regresamos a comparar

saltoDeLinea:                ; metodo para imrpimir un salto de linea
    push eax                 ; guardamos el valor de eax
    mov eax, saltoLinea      ; cargamos el primer mensaje
    call sprintLF            ; mandamos a llamar al "metodo" que imprime
    pop eax                  ; sacamos el valor de eax
    ret

strlen:                      ; Recibe direccion de cadena a medir longitud en EAX ; Regresa en EAX el conteo de caracteres de la cadena
    push EBX                 ; salvamos el valor de EBX en la pila (stack)
    mov EBX,EAX              ; copiamos la direccion del mensaje a EBX

sigcar:
    cmp byte[EAX],0          ; comparamos el byte que esta en la direccion. a la que apunta EAX comn 0 (estamos buscando el caracter de terminacion 0)
    jz finalizar             ; JUMP if Zero, salta a finalizar si es cero
    inc EAX                  ; incrementamos en 1 el acumulador
    jmp sigcar               ; salto incondicional al siguiente caracter

finalizar:
    sub EAX,EBX              ; restamos al valor inicial de memoria el valor final de memoria
    pop EBX                  ; establecer EBX
    ret

quit:
salida:                      ; funcion para terminar de ejecutar el codigo
    mov eax, sys_exit        ; SYS_EXIT
    int 80h                  ; llamada al sistema

sprint:
    push EDX                 ; salvamos valor de EDX
    push ECX                 ; salvamos valor de ECX
    push EBX                 ; salvamos valor de ECX
    push EAX                 ; salvamos valor de EAX
    call strlen              ; llamamos a la funcion strlen
    mov EDX,EAX              ; movemos la longitud de cadena a EDX
    pop EAX                  ; traemos del stack el valor de EAX
    mov ECX,EAX              ; la direccion del mensaje a ECx
    mov EBX,stdout           ; descriptor de archivo(stdout)
    mov EAX,sys_write        ; sys_write
    int 80h                  ; ejecuta
    pop EBX                  ; re-establecemos EBX
    pop ECX                  ; re-establecemos ECX
    pop EDX                  ; re-establecemos EDX
    ret

    ; imprime cadenas de texto con una nueva linea (LF o Line Feed)
sprintLF:
    call sprint              ; llama e imprime el mensaje
    push EAX                 ; salvamos EAX,vamos a utilizarlo en esta funcion
    mov EAX,0xA              ; Hexadecimal para caracter de lineFeed
    push EAX                 ; salvamos el 0xA en el stack
    mov EAX,ESP              ; Lo que apunta ESP a EAX
    call sprint              ; Imprimimos el LF
    pop EAX                  ; Recuperamos el caracter 0xA
    pop EAX                  ; Recuperamos el valor original de 0xA
    ret

    ; funcion iprint (integer print ) o impresion de enteros
iprint:
    push eax                 ; salvamos eax en el stack (acumulador)
    push ecx                 ; salvamos ecx en el stack (contador)
    push edx                 ; salvamos edx en el stack (base)
    push esi                 ; salvamos esi en el stack ( source index)
    mov ecx,0                ; vamos a contar cuantos bytes necesitamos imprimir

dividirLoop:
    inc ecx                  ; incrementamos en 1 ecx
    mov edx,0                ; limpiamos edx
    mov esi,10               ; guardamos 10 en esi , vamos a divir entre 10
    idiv esi                 ; divide eax entre esi
    add edx , 48             ; agregamos el caracter 48 '0'
    push edx                 ; la representacion de ascii de nuestro numero
    cmp eax,0                ; se puede dividir mas el numero entero ?
    jnz dividirLoop          ; jum if not zero (salta si no es cero)

imprimirloop:
    dec ecx                  ; vamos a contar hacia abajo cada byte en el stack
    mov eax,esp              ; aputador del stack a eax
    call sprint              ; llamamos ala funcion sprint
    pop eax                  ; removemos el ultimo caracter del stack
    cmp ecx ,0               ; ya imprimos todos los bytes del stack ?
    jnz imprimirloop         ; todabia hay numeros que imprimir ?
    pop esi                  ; re - estabnlecemos el valor de esi
    pop edx                  ; re-establecemos el valor de edx
    pop ecx                  ; re-establecemos el valor de ecx
    pop eax                  ; re-establecemos el valor de eax
    ret

    ; funcion iprintlf (integer print ) o impresion de enteros con line feed
iprintLF:
    call iprint              ; imprimimo el numeros
    push eax                 ; salvamos el dato que traemos en el acumulador
    mov eax,0xA              ; copiamos el line feed a eax
    push eax                 ; salvamos el line feed en el stack
    mov eax, esp             ; copiamos el apuntador del stack a eax  estamos apuntando a una direccion de memoria
    call sprint              ; imiprimos el line feed
    pop EAX                  ; remomovemos el linefeed del stack
    pop EAX                  ; re-establecemos el dato que traiamos en eax
    ret

    ; ----------------------------------   3 parcial
    ; int atoi  ( entero)
    ; convierte ascii a entero
    ; ------------------------------------------------
atoi:
    push ebx                 ; preservamos ebx
    push ecx                 ; preservamos edx
    push edx                 ; preservamos edx
    push esi                 ; preservamos esi
    mov  esi,eax             ; nuestro numero a convertir va a esi
    mov eax,0                ; inicializamos a cero eax
    mov ecx,0                ; inicializamos a cero ecx

ciclomult:                   ; ciclo multiplicacion
    xor ebx,ebx              ; resetteamos a 0 ebx, tanto  bh como bl
    mov bl,[esi+ecx]         ; movemos un solo byte a ala parte baja de ebx
    cmp bl, 48               ; comparamos con ascii ´0´
    jl  finalizado           ; si es menor , saltamos a finalizado.
    cmp bl,57                ; comparamos con ascci "9"
    jg  finalizado           ; si es mayor, saltamos a finalizado
    cmp bl, 10               ; comparamos con linefeed
    je  finalizado           ; si es igual, saltamos a finalizado
    cmp bl, 0                ; comparamos con caracter null ](fin de caneda)
    jz finalizado            ; si es cero saltamos a finalizado
    sub bl,48                ; convertimos el caracter en entero
    add eax,ebx              ; agreagamos el valor a eax
    mov ebx,10               ; movemos el decimal 10 a ebx
    mul ebx                  ; multiplicamos eax por ebc para obtener el lugar decimal
    inc ecx                  ; incrementamos ecx (conttador)
    jmp ciclomult            ; seguimos nuestro ciclo de multiplicacion

finalizado:
    mov ebx,10               ; movemos el valor decimal 10 a ebx
    div ebx                  ; dividimos eax entre 10
    pop esi                  ; re-establecemos esi
    pop edx                  ; re-establecemos edx
    pop ecx                  ; re-establecemos ecx
    pop ebx                  ; re-establecemos ebx
    ret

    ; compara el valor de eax con ebx, si eax es mayor mueve dicho valor a ebx
numeroMayor:
    cmp eax, edx             ; comparamos eax con edx
    jg moverEAXaEDX          ; vamos a "setearDatos"
    ret

moverEAXaEDX:
    mov edx, eax             ; movemos el valor de eax a edx
    ret

    ; compara el valor de eax con ecx, si eax es menor mueve dicho valor a ecx
numeroMenor:
    cmp eax, ecx             ; comparamos eax con ecx
    jl moverEAXaECX          ; vamos a "setearDatos"
    ret

moverEAXaECX:
    mov ecx, eax             ; movemos el valor de eax a ecx
    ret

LeerTexto:                   ; para leer texto desde el teclado
    mov ebx, stdin
    mov eax, sys_read
    int 80H
    ret

copystring:
    push ecx
    push ebx
    mov ebx, 0
    mov ecx, 0

.sigcar:
    mov bl, byte[eax]
    cmp bl, 0xA
    je .salto

    mov byte[esi+ecx], bl
    cmp byte[eax], 0

    jz .finalizar

.salto:
    inc eax
    inc ecx
    jmp .sigcar

.finalizar:
    pop ebx
    pop ecx
    ret

stringToArrayNum:            ; este metodo toma todo un str con numeros y los mete en un array
    push eax                 ; guardamos valores
    push edx                 ; guardamos valores
    mov edx, 0               ; movemos 0 a edx
    mov eax, letra           ; esto es para que sea un str vacio
    mov ecx, 0               ; movemos 0 a ecx
    mov ebp, 0               ; movemos 0 a edp
    mov edi, 0               ; movemos 0 a edi

.sigcar:                     ; esto recorre los str para pasarlos a eax y hacerlos numeros y luego al array
    mov dl, byte[ebx]        ; pasamos el byte a dl
    cmp dl, 0xA              ; comparamos si es el salto de linea
    je .salto                ; si es salto de linea vamos a .salto

    mov [eax+ebp], dl        ; si no movemos el byte a eax
    inc ebx                  ; incrementamos ebx para tomar el otro char
    inc ebp                  ; incrementamos ebp para escribir en otra posicion
    jmp .sigcar              ; regresamos

.salto:                      ; salto, esto hace la convercion de eax y lo mete al array
    call atoi                ; llamamos a la convercion de acsii a int
    mov [esi+edi*4], eax     ; movemos el numero al array que esta en esi
    mov eax, letra           ; seteamos eax en str vacio otra vez
    mov ebp, 0               ; movemos el contador de chars a 0

    inc ebx                  ; incrementamos ebx para tomar el otro char
    inc edi                  ; incrementamos edi para escribir en otra posicion en esi

    cmp byte[ebx], 0         ; comparamos con 0 para saber si es el final
    jz .finalizar            ; si es el final de str vamos a .finalizar

    jmp .sigcar              ; regresamos

.finalizar:
    pop edx                  ; regresamos los valores
    pop eax                  ; regresamos los valores
    ret

    ; ------------------------------------
    ; itoa recibe un entero
    ; y lo convierte en cadena de texto
    ; recibe entero en EAX
    ; recibe direccion de cadena en ESI
    ; ------------------------------------
itoa:
    push ebx                 ; preservamos ebx
    push ecx                 ; preservamos ecx
    push edx                 ; preservamos edx
    push esi                 ; preservamos esi

    mov ebx, 10              ; vamos a dividir por 10
    mov ecx, 0               ; nuestro contador en
    push ecx                 ; mandamos 0 al stack (fin de cadena)
    inc ecx

.dividir:
    inc ecx
    mov edx, 0
    idiv ebx
    add edx, 0x30            ; agregamos 48 (para obtener digitos de 0-9 en ASCII)
    push edx                 ; enviamos el residuo al stack
    cmp eax, 0               ; checamos si el residuo es 0
    je .fuera                ; si es 0, salimos del ciclo
    jmp .dividir             ; seguimos obteniendo digitos

.fuera:
    mov ebx,0                ; limpiamos ebx

.guardar:
    pop eax                  ; traemos un digito del stack
    mov byte[esi+ebx],al     ; movemos el digito a memoria
    inc ebx                  ; incrementamos contador
    cmp ebx,ecx              ; comparamos con la cuenta de digitos
    jne .guardar             ; si no son iguales, obtenemos otro digito del stack

    pop esi                  ; restauramos esi
    pop edx                  ; restauramos edx
    pop ecx                  ; restauramos ecx
    pop ebx                  ; restauramos ebx
    ret                      ; y regresamos
