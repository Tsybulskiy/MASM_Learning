

.data
    format_in    db '%d', 0
    format_out   db 'Сумма от 1 до %d: %d', 0Ah, 0
    number       dd 0
    result       dd 0

.code
extern scanf:PROC
extern printf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, format_in
    lea rdx, number
    call scanf

    mov ecx, [number]    
    mov eax, 0           

    cmp ecx, 0
    jle sum_done          

sum_loop:
    add eax, ecx
    dec ecx
    cmp ecx, 0
    jne sum_loop

sum_done:
    mov [result], eax

    lea rcx, format_out
    mov edx, [number]
    mov r8d, [result]
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
