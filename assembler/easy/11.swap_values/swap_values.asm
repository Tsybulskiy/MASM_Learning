
.data
    prompt1     db 'Введите первое число (A): ', 0
    prompt2     db 'Введите второе число (B): ', 0
    format_in   db '%d', 0
    format_out  db 'После обмена: A = %d, B = %d', 0Ah, 0
    numA        dd 0
    numB        dd 0

.code
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, prompt1
    call printf
    lea rcx, format_in
    lea rdx, numA
    call scanf

    lea rcx, prompt2
    call printf
    lea rcx, format_in
    lea rdx, numB
    call scanf

    mov eax, [numA]
    mov ebx, [numB]
    xor eax, ebx
    xor ebx, eax
    xor eax, ebx
    mov [numA], eax
    mov [numB], ebx

    lea rcx, format_out
    mov edx, [numA]
    mov r8d, [numB]
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
