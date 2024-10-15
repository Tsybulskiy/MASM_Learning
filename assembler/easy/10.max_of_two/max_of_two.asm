

.data
    prompt1     db 'Введите первое число: ', 0
    prompt2     db 'Введите второе число: ', 0
    format_in   db '%d', 0
    format_out  db 'Максимальное число: %d', 0Ah, 0
    num1        dd 0
    num2        dd 0
    max_num     dd 0

.code
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, prompt1
    call printf
    lea rcx, format_in
    lea rdx, num1
    call scanf

    lea rcx, prompt2
    call printf
    lea rcx, format_in
    lea rdx, num2
    call scanf

    mov eax, [num1]
    mov ebx, [num2]
    cmp eax, ebx
    jge first_is_max

    mov [max_num], ebx
    jmp display_result

first_is_max:
    mov [max_num], eax

display_result:
    lea rcx, format_out
    mov edx, [max_num]
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
