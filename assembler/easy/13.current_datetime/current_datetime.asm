

.DATA
    format_out db 'Текущая дата и время: %s', 0Ah, 0
    time_var    dq 0

.CODE
    extern printf: PROC
    extern time: PROC
    extern ctime: PROC
    extern ExitProcess: PROC

    main PROC
        sub rsp, 28h              

        lea rcx, time_var        
        call time                 

        mov rcx, OFFSET time_var  
        call ctime                

        lea rcx, format_out       
        mov rdx, rax              
        call printf               

        add rsp, 28h              
        xor rcx, rcx              
        call ExitProcess                
    main ENDP
    END
