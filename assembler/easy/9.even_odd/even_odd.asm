
.data
    prompt      db 'Введите число: ', 0
    format_in   db '%d', 0
    even_msg    db '%d является чётным числом.', 0Ah, 0
    odd_msg     db '%d является нечётным числом.', 0Ah, 0
    number      dd 0

.code
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, prompt
    call printf

    lea rcx, format_in
    lea rdx, number
    call scanf

    mov eax, [number]
    and eax, 1          
    cmp eax, 0
    je is_even

is_odd:
    lea rcx, odd_msg
    mov edx, [number]
    call printf
    jmp end_program

is_even:
    lea rcx, even_msg
    mov edx, [number]
    call printf

end_program:
    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
