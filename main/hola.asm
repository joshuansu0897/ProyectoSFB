section .data
    mensaje DB 'Hola Mundo!',0xA,0x0
    longitud EQU $ - mensaje

section .text
    GLOBAL _start     ; declaramos punto de inicio
_start:
    mov ECX, mensaje  ; cargamos la direccion del mensaje a imprimir
    mov EDX, longitud ; longitud del mensaje
    mov EBX, 1        ; salida estandar (STDOUT)
    mov EAX, 4        ; SYS_WRITE
    int 0x80          ; llamamos al kernel
    mov EAX, 1        ; SYS_EXIT
    int 0x80          ; llamada al sistema
