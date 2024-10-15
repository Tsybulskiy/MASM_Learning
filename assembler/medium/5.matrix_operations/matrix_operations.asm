

.DATA
    prompt_matrix1_row0_col0 db 'Введите элемент матрицы1 [0][0]: ', 0
    prompt_matrix1_row0_col1 db 'Введите элемент матрицы1 [0][1]: ', 0
    prompt_matrix1_row1_col0 db 'Введите элемент матрицы1 [1][0]: ', 0
    prompt_matrix1_row1_col1 db 'Введите элемент матрицы1 [1][1]: ', 0

    prompt_matrix2_row0_col0 db 'Введите элемент матрицы2 [0][0]: ', 0
    prompt_matrix2_row0_col1 db 'Введите элемент матрицы2 [0][1]: ', 0
    prompt_matrix2_row1_col0 db 'Введите элемент матрицы2 [1][0]: ', 0
    prompt_matrix2_row1_col1 db 'Введите элемент матрицы2 [1][1]: ', 0

    format_in          db '%d', 0
    format_out         db 'Результат сложения матриц:', 0Ah, 0
    format_element     db '%d ', 0
    format_newline     db 0Ah, 0

    matrix1    dd 4 dup(0)    
    matrix2    dd 4 dup(0)   
    result     dd 4 dup(0)    

.CODE
extern printf:PROC
extern scanf:PROC
extern ExitProcess:PROC

main PROC
    sub rsp, 40h

    lea rcx, prompt_matrix1_row0_col0
    call printf
    lea rcx, format_in
    lea rdx, matrix1         
    call scanf

    lea rcx, prompt_matrix1_row0_col1
    call printf
    lea rcx, format_in
    lea rdx, matrix1 + 4      
    call scanf

    lea rcx, prompt_matrix1_row1_col0
    call printf
    lea rcx, format_in
    lea rdx, matrix1 + 8      
    call scanf

    lea rcx, prompt_matrix1_row1_col1
    call printf
    lea rcx, format_in
    lea rdx, matrix1 + 12     
    call scanf

    lea rcx, prompt_matrix2_row0_col0
    call printf
    lea rcx, format_in
    lea rdx, matrix2          
    call scanf

    lea rcx, prompt_matrix2_row0_col1
    call printf
    lea rcx, format_in
    lea rdx, matrix2 + 4      
    call scanf

    lea rcx, prompt_matrix2_row1_col0
    call printf
    lea rcx, format_in
    lea rdx, matrix2 + 8      
    call scanf

    lea rcx, prompt_matrix2_row1_col1
    call printf
    lea rcx, format_in
    lea rdx, matrix2 + 12     
    call scanf

    mov eax, DWORD PTR [matrix1]     
    add eax, DWORD PTR [matrix2]       
    mov DWORD PTR [result], eax        

    mov eax, DWORD PTR [matrix1 + 4]   
    add eax, DWORD PTR [matrix2 + 4]   
    mov DWORD PTR [result + 4], eax   

    mov eax, DWORD PTR [matrix1 + 8]   
    add eax, DWORD PTR [matrix2 + 8]   
    mov DWORD PTR [result + 8], eax    

    mov eax, DWORD PTR [matrix1 + 12]  
    add eax, DWORD PTR [matrix2 + 12]  
    mov DWORD PTR [result + 12], eax   


    lea rcx, format_out
    call printf

    lea rcx, format_element
    mov edx, DWORD PTR [result]        
    call printf

    lea rcx, format_element
    mov edx, DWORD PTR [result + 4]     
    call printf

    lea rcx, format_newline
    call printf

    lea rcx, format_element
    mov edx, DWORD PTR [result + 8]     
    call printf

    lea rcx, format_element
    mov edx, DWORD PTR [result + 12]   

    call printf

    lea rcx, format_newline
    call printf

    add rsp, 40h
    xor rcx, rcx                       
    call ExitProcess
main ENDP
END