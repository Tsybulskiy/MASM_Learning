

.data
    prompt      db 'Введите строку: ', 0
    format_out  db 'Длина строки: %d', 0Ah, 0
    buffer      db 256 dup(0)

.code
extern printf:PROC
extern gets:PROC
extern strlen:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, prompt
    call printf

    lea rcx, buffer
    call gets

    lea rcx, buffer
    call strlen

    lea rcx, format_out
    mov edx, eax
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
