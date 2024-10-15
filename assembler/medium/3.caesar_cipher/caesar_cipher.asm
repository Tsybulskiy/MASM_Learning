
extern printf : proc
extern scanf : proc
extern ExitProcess : proc

.data
    prompt_text      db 'Введите текст для шифрования: ', 0
    prompt_shift     db 'Введите значение сдвига: ', 0
    format_in_str    db '%255s', 0          
    format_in_shift  db '%d', 0
    format_out       db 'Зашифрованный текст: %s', 0Ah, 0
    input_buffer     db 256 dup(0)          
    shift_value      dq 0                 

.code
main PROC
    lea     rcx, prompt_text       
    call    printf

    lea     rcx, format_in_str     
    lea     rdx, input_buffer      
    call    scanf

    lea     rcx, prompt_shift      
    call    printf

    lea     rcx, format_in_shift   
    lea     rdx, shift_value      
    call    scanf

    mov     eax, DWORD PTR [shift_value]
    and     eax, 1Fh                
    cmp     eax, 26
    jl      ShiftOk
    sub     eax, 26
ShiftOk:
    mov     DWORD PTR [shift_value], eax

    lea     rsi, input_buffer      
    mov     ecx, 0                  

EncryptLoop:
    mov     al, BYTE PTR [rsi + rcx] 
    cmp     al, 0
    je      EncryptionDone         

    cmp     al, 'A'
    jb      CheckLowercase
    cmp     al, 'Z'
    jbe     EncryptUpper

CheckLowercase:
    cmp     al, 'a'
    jb      NextChar
    cmp     al, 'z'
    jbe     EncryptLower
    jmp     NextChar

EncryptUpper:
    mov     al, BYTE PTR [rsi + rcx]
    add     al, BYTE PTR [shift_value]
    cmp     al, 'Z'
    jg      WrapUpper
    jmp     StoreCharUpper

WrapUpper:
    sub     al, 26

StoreCharUpper:
    mov     BYTE PTR [rsi + rcx], al
    jmp     NextChar

EncryptLower:
    mov     al, BYTE PTR [rsi + rcx]
    add     al, BYTE PTR [shift_value]
    cmp     al, 'z'
    jg      WrapLower
    jmp     StoreCharLower

WrapLower:
    sub     al, 26

StoreCharLower:
    mov     BYTE PTR [rsi + rcx], al

NextChar:
    inc     ecx
    jmp     EncryptLoop

EncryptionDone:
    lea     rcx, format_out         
    lea     rdx, input_buffer       

    call    printf

    xor     ecx, ecx                
    call    ExitProcess
main ENDP

END 