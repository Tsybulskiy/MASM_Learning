.data
    filename    db 'input.txt', 0
    mode        db 'r', 0
    buffer      db 256 DUP(0)
    fmt_string  db '%s', 0
    error_msg   db 'Не удалось открыть файл.', 0Ah, 0

.code
extern fopen:PROC
extern fgets:PROC
extern printf:PROC
extern fclose:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h   

    lea rcx, filename    
    lea rdx, mode        
    call fopen
    mov rbx, rax         

    cmp rax, 0
    je file_error

read_loop:
    lea rcx, buffer      
    mov edx, 256         
    mov r8, rbx          
    call fgets
    cmp rax, 0
    je end_read          

    lea rcx, fmt_string
    lea rdx, buffer
    call printf

    jmp read_loop

end_read:
    mov rcx, rbx
    call fclose

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess

file_error:
    lea rcx, error_msg
    call printf

    add rsp, 28h
    mov ecx, 1
    call ExitProcess
main ENDP
END