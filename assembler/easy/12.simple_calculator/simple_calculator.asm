.data
    prompt1         db 'Введите первое число: ', 0
    prompt2         db 'Введите второе число: ', 0
    menu            db 'Выберите операцию (+, -, *, /): ', 0
    format_in       db '%d', 0
    format_char     db ' %c', 0             
    format_out      db 'Результат: %d', 0Ah, 0
    num1            dd 0
    num2            dd 0
    result          dd 0
    operation       db 0 
    
    invalid_msg     db 'Неверная операция!', 0Ah, 0
    division_zero   db 'Ошибка: деление на ноль!', 0Ah, 0

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

    lea rcx, menu
    call printf
    lea rcx, format_char
    lea rdx, operation
    call scanf

    mov al, [operation]             

    cmp al, '+'
    je do_addition

    cmp al, '-'
    je do_subtraction

    cmp al, '*'
    je do_multiplication

    cmp al, '/'
    je do_division

    lea rcx, invalid_msg
    call printf
    jmp end_program

do_addition:
    mov eax, [num1]            
    add eax, [num2]           
    jmp show_result

do_subtraction:
    mov eax, [num1]             
    sub eax, [num2]             
    jmp show_result

do_multiplication:
    mov eax, [num1]             
    imul eax, [num2]            
    jmp show_result

do_division:
    mov ecx, [num2]             
    cmp ecx, 0                 
    je division_by_zero         

    mov eax, [num1]             
    cdq                         
    idiv ecx                    
    jmp show_result

division_by_zero:
    lea rcx, division_zero      
    call printf
    jmp end_program

show_result:
    mov [result], eax            
    lea rcx, format_out         
    mov eax, [result]            
    mov edx, eax                 
    call printf
    jmp end_program

end_program:
    add rsp, 28h                
    xor rcx, rcx                 
    call ExitProcess
main ENDP
END
