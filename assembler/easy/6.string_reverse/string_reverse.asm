

.data
    prompt      db 'Введите строку: ', 0
    format_out  db 'Реверс строки: %s', 0Ah, 0
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
    mov ecx, eax       

    lea rsi, buffer   
    lea rdi, buffer    
    add rdi, rcx       
    dec rdi            

reverse_loop:
    cmp rsi, rdi
    jge reverse_done
    mov al, [rsi]
    mov bl, [rdi]
    mov [rsi], bl
    mov [rdi], al
    inc rsi
    dec rdi
    jmp reverse_loop

reverse_done:
    lea rcx, format_out
    lea rdx, buffer
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
