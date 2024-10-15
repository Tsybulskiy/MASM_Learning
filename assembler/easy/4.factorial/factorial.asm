

.data
    format_in    db '%d', 0
    format_out   db '%d! = %d', 0Ah, 0
    number       dd 0
    result       dd 1          
    invalid_msg  db 'Vvedeno nepravilno' , 0Ah, 0 
.code
extern scanf:PROC
extern printf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h


    lea rcx, format_in
    lea rdx, number
    call scanf


    mov eax, [number]
    cmp eax, 0
    jl invalid_input


    mov ecx, eax        
    cmp ecx, 1
    jle skip_loop       

    mov rax, 1          
factorial_loop:
    mul rcx            
    dec ecx             
    cmp ecx, 1
    jg factorial_loop

    mov [result], rax
    jmp display_result

invalid_input:
    lea rcx, invalid_msg
    call printf
    jmp exit_program

skip_loop:
    mov [result], 1

display_result:
    lea rcx, format_out
    mov edx, [number]
    mov r8, [result]
    call printf

exit_program:
    add rsp, 28h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
