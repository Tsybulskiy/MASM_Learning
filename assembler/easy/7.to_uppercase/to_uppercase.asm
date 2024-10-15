

.data
    prompt      db '‚Ά¥¤¨β¥ αβΰ®ªγ: ', 0
    format_out  db '¥§γ«μβ β: %s', 0Ah, 0
    buffer      db 256 dup(0)

.code
extern printf:PROC
extern gets:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h

    lea rcx, prompt
    call printf

    lea rcx, buffer
    call gets

    lea rsi, buffer
convert_loop:
    mov al, [rsi]
    cmp al, 0
    je convert_done
    cmp al, 'a'
    jb next_char
    cmp al, 'z'
    ja next_char
    sub al, 32         
    mov [rsi], al
next_char:
    inc rsi
    jmp convert_loop

convert_done:
    lea rcx, format_out
    lea rdx, buffer
    call printf

    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
