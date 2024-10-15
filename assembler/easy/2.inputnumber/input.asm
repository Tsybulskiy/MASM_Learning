

.data
    format_in    db '%d', 0          
    format_out   db 'Vvdeno chislo: %d', 0Ah, 0
    number       dd 0                  

.code
extern scanf:PROC
extern printf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 28h           

    lea rcx, format_in     
    lea rdx, number        
    call scanf            

    lea rcx, format_out    
    mov edx, [number]      
    call printf            )

    add rsp, 28h           
    xor rcx, rcx           
    call ExitProcess       
main ENDP
END
