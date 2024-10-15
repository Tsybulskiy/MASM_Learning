
.DATA
    array       DWORD 5, 3, 2, 4, 1
    n           DWORD 5                

    prompt      DB 'Отсортированный массив: ', 0
    format_out  DB '%d ', 0
    newline     DB 0Ah, 0

.CODE
    EXTERN printf:PROC
    EXTERN ExitProcess:PROC

    PUBLIC main
    main PROC
        sub     rsp, 40h              

        mov     ecx, [n]              
        dec     ecx                  
        mov     esi, 0               

    outer_loop:
        cmp     esi, ecx              
        jge     sort_done             

        mov     edi, 0                

        mov     edx, [n]
        sub     edx, esi              
        dec     edx                   

    inner_loop:
        cmp     edi, edx              
        jge     next_outer            

 
        mov     eax, [array + edi*4]            
        mov     ebx, [array + edi*4 + 4]        
        cmp     eax, ebx
        jle     no_swap              


        mov     [array + edi*4], ebx 
        mov     [array + edi*4 + 4], eax 

    no_swap:
        inc     edi                   
        jmp     inner_loop            

    next_outer:
        inc     esi                   
        jmp     outer_loop            

    sort_done:
        lea     rcx, prompt           
        call    printf

        mov     esi, 0                

    print_loop:
        cmp     esi, [n]
        jge     print_done             

        mov     eax, [array + esi*4]  
        mov     rdx, rax              
        lea     rcx, format_out       
        call    printf

        inc     esi                   
        jmp     print_loop

    print_done:
        lea     rcx, newline          
        call    printf

        add     rsp, 40h
        xor     ecx, ecx              
        call    ExitProcess
    main ENDP
    END
