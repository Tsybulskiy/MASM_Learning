
   option casemap: none          
   .data
       prompt      db 'Введите N: ', 0
       format_in   db '%d', 0
       format_out  db 'Последовательность Фибоначчи до %d элементов:', 0Ah, 0
       format_num  db '%d ', 0
       N           dd 0
       a           dd 0
       b           dd 1
       counter     dd 0

   .code
       extern printf: PROC
       extern scanf: PROC
       extern ExitProcess: PROC


   main PROC
       

       lea rcx, prompt          
       call printf

       lea rcx, format_in        
       lea rdx, N                
       call scanf

       lea rcx, format_out       
       mov eax, [N]              
       movsxd rdx, eax           
       call printf

       mov dword ptr [a], 0       
       mov dword ptr [b], 1       
       mov dword ptr [counter], 0 

   fib_loop:
       mov eax, [counter]
       cmp eax, [N]
       jge end_fib

       lea rcx, format_num       
       mov eax, [a]             
       movsxd rdx, eax           
       call printf

       mov eax, [a]
       add eax, [b]
       mov edx, [b]             
       mov [a], edx              
       mov [b], eax              

       inc dword ptr [counter]
       jmp fib_loop

   end_fib:
       mov rcx, 0                
       call ExitProcess          
   main ENDP
   END