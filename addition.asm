section .data
    num1    dd 10
    num2    dd 3
    msg     db "Result: ",0
    msgLen  equ $ - msg
    buf     times 20 db 0      ; buffer for number string
    newline db 0x0A

section .text
    global _start

_start:
    ; Load numbers
    mov eax, [num1]
    add eax, [num2]       ; eax = num1 + num2

    ; Convert eax to string (decimal)
    mov esi, buf + 20     ; point to end of buffer
    mov ebx, 10

convert_loop:
    xor edx, edx
    div ebx               ; eax / 10 → quotient in eax, remainder in edx
    add dl, '0'           ; remainder → ASCII
    dec esi
    mov [esi], dl
    test eax, eax
    jnz convert_loop

    ; Print "Result: "
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, msg
    mov edx, msgLen
    int 0x80

    ; Print number
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, buf + 20
    sub edx, esi          
    int 0x80

    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
