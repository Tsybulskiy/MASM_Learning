

.DATA
    prompt_start    db 'Введите начальное число: ', 0
    prompt_end      db 'Введите конечное число: ', 0
    format_in       db '%d', 0
    format_out      db 'Простое число: %d', 0Ah, 0
    start_num       dd 0
    end_num         dd 0

.CODE
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

public main

main PROC
    sub rsp, 40h          

    lea rcx, prompt_start 
    call printf

    lea rcx, format_in   
    lea rdx, start_num    
    call scanf

    lea rcx, prompt_end
    call printf

    lea rcx, format_in
    lea rdx, end_num
    call scanf

    mov eax, DWORD PTR [start_num]  
    mov r10d, eax                   
    mov ebx, DWORD PTR [end_num]   

    cmp eax, 2
    jl set_start_to_2
    jmp check_range

set_start_to_2:
    mov eax, 2
    mov DWORD PTR [start_num], eax    
    mov r10d, eax                     

check_range:
    cmp eax, ebx
    jg end_program                   

search_loop:
    cmp eax, ebx
    jg end_program

    mov r10d, eax                     

    mov ecx, 2                        

    cmp eax, 2
    je is_prime                      

    cmp eax, 1
    jle next_number                   

check_prime_loop:
    cmp ecx, r10d                    
    jge is_prime                      

    mov eax, r10d                     
    mov edx, 0                       

    div ecx                          

    cmp edx, 0
    je not_prime                      

    inc ecx                           
    jmp check_prime_loop              

is_prime:
    lea rcx, format_out               
    mov edx, r10d                     
    xor eax, eax                     
    call printf
    jmp next_number

not_prime:
    jmp next_number

next_number:
    inc DWORD PTR [start_num]          
    mov eax, DWORD PTR [start_num]     
    jmp search_loop

end_program:
    add rsp, 40h
    mov ecx, 0                         
    call ExitProcess                   

main ENDP
END
