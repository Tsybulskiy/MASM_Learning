.DATA
    prompt         DB 'Введите десятичное число: ', 0
    format_in      DB '%d', 0
    format_out     DB 'Двоичное представление числа: %s', 10, 0
    bin_buffer     DB 33 DUP(0)      
    num            DD 0

.CODE
EXTERN printf:PROC
EXTERN scanf:PROC
EXTERN ExitProcess:PROC

main PROC
    lea     rcx, prompt
    call    printf

    lea     rcx, format_in
    lea     rdx, num
    call    scanf

    lea     rdi, bin_buffer
    mov     ecx, 32            
    mov     eax, [num]

    mov     byte ptr [rdi + 32], 0

convert_loop:
    dec     ecx
    mov     bl, '0'                
    test    eax, 1
    jz      set_zero
    mov     bl, '1'                
set_zero:
    mov     [rdi + rcx], bl
    shr     eax, 1
    cmp     ecx, 0
    jne     convert_loop

    lea     rsi, bin_buffer            
    mov     ecx, 32                   
    mov     rdx, 0                    

find_first_one:
    cmp     BYTE PTR [rsi + rdx], '1'
    je      found_one
    inc     rdx
    dec     ecx
    jnz     find_first_one
    jmp     prepare_output            

found_one:
    lea     rsi, bin_buffer
    add     rsi, rdx

prepare_output:
    lea     rcx, format_out
    mov     rdx, rsi                  
    call    printf

    xor     rcx, rcx
    call    ExitProcess
main ENDP
END