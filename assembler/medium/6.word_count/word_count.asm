extern fopen: PROC
extern fclose: PROC
extern fgetc: PROC
extern printf: PROC
extern ExitProcess: PROC

.data
    filename        db "input.txt",0              
    fileMode        db "r",0                       
    format_out      db "Количество слов в файле: %d", 0Ah, 0
    wordCount       dd 0                           
    currentChar     db 0                            
    inWord          db 0                           

.code
main PROC
    sub     rsp, 40h          

    lea     rcx, filename      
    lea     rdx, fileMode      
    call    fopen
    test    rax, rax           
    jz      file_error
    mov     rdi, rax           

    mov     dword ptr [wordCount], 0
    mov     byte ptr [inWord], 0

read_loop:
    mov     rcx, rdi          
    call    fgetc
    mov     al, al             
    cmp     al, -1             
    je      end_read
    mov     [currentChar], al

    cmp     al, ' '
    je      separator
    cmp     al, 9             
    je      separator
    cmp     al, 10             
    je      separator
    cmp     al, 13             
    je      separator

    cmp     byte ptr [inWord], 0
    jne     continue_loop      
    inc     dword ptr [wordCount] 
    mov     byte ptr [inWord], 1  
    jmp     continue_loop

separator:
    mov     byte ptr [inWord], 0  

continue_loop:
    jmp     read_loop

end_read:
    mov     rcx, rdi           
    call    fclose

    lea     rcx, format_out    
    mov     edx, [wordCount]   
    call    printf

    add     rsp, 40h           
    xor     rcx, rcx          
    call    ExitProcess

file_error:
    lea     rcx, format_out    
    mov     edx, 0             
    call    printf

    add     rsp, 40h           
    xor     rcx, rcx           
    call    ExitProcess

main ENDP
END
