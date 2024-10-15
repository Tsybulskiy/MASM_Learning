
;ml64 /c /Fohello.obj hello.asm 
;link.exe hello.obj /subsystem:console /defaultlib:kernel32.lib /entry:main /machine:x64
extrn GetStdHandle: PROC
extrn WriteConsoleA: PROC
extrn ExitProcess: PROC

.data
    message db 'Hello, World!', 0Ah, 0    
.code
main PROC
    sub rsp, 28h     


    mov rcx, -11     
    call GetStdHandle


    mov r12, rax     

    lea rdx, message                
    mov r8d, LENGTHOF message - 1   
    xor r9d, r9d                     
    mov rcx, r12                     

    call WriteConsoleA               


    xor rcx, rcx                    
    call ExitProcess               
main ENDP

END
