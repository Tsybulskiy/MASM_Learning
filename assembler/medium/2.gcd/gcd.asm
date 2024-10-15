

.DATA
    prompt1     DB 'Введите первое число (A): ', 0
    prompt2     DB 'Введите второе число (B): ', 0
    format_in   DB '%d', 0
    format_out  DB 'НОД = %d', 0Ah, 0

    numA        DWORD 0
    numB        DWORD 0

.CODE
EXTERN printf:PROC
EXTERN scanf:PROC
EXTERN ExitProcess:PROC

PUBLIC main
main PROC
    sub     rsp, 28h              



    lea     rcx, prompt1
    call    printf
    lea     rcx, format_in
    lea     rdx, numA
    call    scanf

    lea     rcx, prompt2
    call    printf
    lea     rcx, format_in
    lea     rdx, numB
    call    scanf

    mov     eax, [numA]          
    mov     ebx, [numB]          

gcd_loop:
    cmp     ebx, 0
    je      gcd_done              
    mov     edx, 0
    div     ebx                   
    mov     eax, ebx              
    mov     ebx, edx              
    jmp     gcd_loop

gcd_done:
    lea     rcx, format_out
    mov     rdx, rax              
    call    printf

    add     rsp, 28h
    xor     rcx, rcx              
    call    ExitProcess
main ENDP
END
