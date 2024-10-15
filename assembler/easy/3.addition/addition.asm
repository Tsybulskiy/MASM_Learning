
.data
    format_in    db '%d', 0            
    format_out   db 'Сумма чисел: %d', 0Ah, 0
    num1         dd 0
    num2         dd 0
    result       dd 0

.code
extern scanf:PROC
extern printf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h           

    lea rcx, format_in
    lea rdx, num1
    call scanf

    lea rcx, format_in
    lea rdx, num2
    call scanf

    mov eax, [num1]
    add eax, [num2]
    mov [result], eax

    lea rcx, format_out
    mov edx, [result]
    call printf

    add rsp, 28h         
    xor rcx, rcx           
    call ExitProcess
main ENDP
END
