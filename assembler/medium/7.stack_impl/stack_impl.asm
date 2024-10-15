

.data
    stack_size  EQU 10
    stack       dq stack_size dup(0)
    top         dq 0

    menu_text   db 'Стек операций:', 0Ah
                db '1. Push (добавить элемент)', 0Ah
                db '2. Pop (извлечь элемент)', 0Ah
                db '3. Выход', 0Ah
                db 'Ваш выбор: ', 0
    enter_value db 'Введите значение: ', 0
    pop_value   db 'Извлеченное значение: %d', 0Ah, 0
    stack_full  db 'Стек полон!', 0Ah, 0
    stack_empty db 'Стек пуст!', 0Ah, 0

    format_in   db '%d', 0
    format_out  db '%d', 0

.code
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 38h       

menu_loop:
    lea rcx, menu_text
    call printf

    lea rcx, format_in
    lea rdx, [rsp+20h]    
    call scanf
    mov eax, [rsp+20h]

    cmp eax, 1
    je do_push
    cmp eax, 2
    je do_pop
    cmp eax, 3
    je exit_program
    jmp menu_loop

do_push:
    mov rax, [top]
    cmp rax, stack_size
    jae stack_is_full

    lea rcx, enter_value
    call printf
    lea rcx, format_in

    lea rdx, [rsp+28h]   
    call scanf
    mov rdx, [rsp+28h]

    mov rax, [top]
    mov [stack + rax*8], rdx
    inc qword ptr [top]
    jmp menu_loop

stack_is_full:
    lea rcx, stack_full
    call printf
    jmp menu_loop

do_pop:
    mov rax, [top]
    cmp rax, 0
    jle stack_is_empty

    dec qword ptr [top]
    mov rax, [top]
    mov rdx, [stack + rax*8]

    lea rcx, pop_value
    call printf
    jmp menu_loop

stack_is_empty:
    lea rcx, stack_empty
    call printf
    jmp menu_loop

exit_program:
    add rsp, 38h
    xor rcx, rcx
    call ExitProcess
main ENDP
END
