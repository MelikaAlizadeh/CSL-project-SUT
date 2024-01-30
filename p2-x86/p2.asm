segment .data
    input_format db "%lf", 0
    input_format_n db "%d", 0
    output_format_n db "%d", 10, 0
    output_format db "%.3lf ", 0
    printnl_format db 10, 0
    output_format_immposible db "Impossible", 0

    COUNTER: dq 1
    FLAG: dq 1
    SUBTRACT: dq 1
    zero: dq 0.0000000


segment .bss
    n resq 1    
    num1 resb 1
    num2 resq 1
    result resq 1
    matrix resq 8008000

segment .text

global asm_main
extern printf
extern scanf
extern exit

asm_main:
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp, 8
    ; -------------------------
    ;read n from input
    mov rdi, input_format_n
    mov rsi, n
    call scanf

    xor r15, r15                    ;r15=n is counter for reading each row
    mov r14, [n]                    ;r14=n is counter for reading each column
    add r14, 1                      ;r14+1 BC there are n+1 elements in each row
    mov [FLAG], r14
    xor r14, r14


read_loop:
    ;read matrix and result of vectors
    mov rdi, input_format
    mov rsi, num1
    call scanf

    ;store numbers in matrix
    mov rbp, matrix             ;store address of matrix
    mov rdi, r15                ;to find the offset dynamically
    mov rsi, r14                ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset
    ; Store the result
    movsd xmm1, qword [num1]
    movsd qword [rbp + rax], xmm1

    inc r14                            ;check condition for first loop to read columns(r14>n+1)
    cmp r14, [FLAG]
    jnz read_loop
loop1_condition:
    mov r14, 0
    inc r15
    cmp r15, [n]                       ;check condition for second loop to read rows(r15>n)
    jnz read_loop
end_read_loop:
    xor r15, r15                       ;r15=n is counter for reading each row
    xor r14, r14                       ;r14=n is counter for reading each column



elimination:                         ;first loop is used to check for a zero diagonal elements == no solution exists
    mov rbp, matrix                  ;store address of matrix
    mov rdi, r15                     ;to find the offset dynamically
    mov rsi, r15                     ;r15=row    r15=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                          ;rax=offset

    movsd xmm0, qword [rbp + rax]            ; Load one double-precision value to XMM0
    movss xmm1, [zero]                       ; if the diagonal contains zero then the answer is Impossible
    ucomisd xmm1, xmm0                       ; Compare xmm1 with xmm0
    je end_if


    movsd xmm0, [rbp + rax]           ; xmm0 is now divisor
    xor r14,r14
second_loop:                            ;make diagonal elements 1
    mov rbp, matrix                     ;store address of matrix
    mov rdi, r15                        ;to find the offset dynamically
    mov rsi, r14                        ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset

    movsd xmm2, qword [rbp + rax]       ;set diagonal elements 1
    divsd xmm2, xmm0
    movsd qword [rbp + rax], xmm2

    inc r14                             ;check condition of loop(j<n+1)
    cmp r14, [FLAG] 
    jnz second_loop


    mov r12, 0
others_loop:                            ;to eliminate other elements in the current column
    cmp r12, r15
    je check

    mov r14,0                            ;third loop counter
    mov rbp, matrix                     ;store address of matrix
    mov rdi, r12                        ;to find the offset dynamically
    mov rsi, r15                        ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset
    
    movsd  xmm2, qword [rbp + rax]       ; xmm0 is now a var to keep the element of matrix
    movsd qword [num2],xmm2
third_loop:                             ;to perform matrix[k][j] -= factor * matrix[i][j];
    
    mov rbp, matrix                     ;store address of matrix
    mov rdi, r15                        ;to find the offset dynamically
    mov rsi, r14                        ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset

    movsd xmm2, qword [num2]
    movsd xmm1, qword [rbp + rax]       ;set diagonal elements 1
    mulsd xmm1, xmm2

    mov rbp, matrix                     ;store address of matrix
    mov rdi, r12                        ;to find the offset dynamically
    mov rsi, r14                        ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset

    movsd xmm0, qword [rbp + rax]       ;set diagonal elements 1
    subsd xmm0, xmm1



    movsd qword [rbp + rax], xmm0

    inc r14                             ;check condition of loop(j<n+1)
    cmp r14, [FLAG] 
    jnz third_loop

check:
    mov r14, 0
    inc r12
    cmp r12, [n]
    jnz others_loop


end_check:
    inc r15
    cmp r15, [n]
    jnz elimination

print_section:
    xor r15, r15
    mov r14, [n]
print_loop:
    mov rbp, matrix             ;store address of matrix
    mov rdi, r15                ;to find the offset dynamically
    mov rsi, r14                ;r15=row    r14=column    rdx=columns=n+1
    mov rdx, [n]
    inc rdx
    call calculate_offset
    inc rax                     ;rax=offset

    movsd xmm2, qword [rbp + rax]
    movsd qword [result], xmm2

    ; Print the result
    mov rdi, output_format
    movsd xmm0, qword [result]
    call printf

    inc r15
    cmp r15, [n]
    jnz print_loop
    jmp end_all

end_if:                                         ;there is no unique solution
    ; Print the result
    mov rdi, output_format_immposible
    call printf
    jmp end_all

end_all:
    mov rdi, printnl_format
    call printf
    ; -------------------------

    add rsp, 8

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp

    ret



; Function to calculate the offset
calculate_offset:
    ; Parameters: row in rdi, column in rsi, columns in rdx
    mov rax, rdi
    imul rax, rdx        ; row * columns
    add rax, rsi         ; (row * columns) + column
    imul rax, 8          ; ((row * columns) + column) * 8 (size of double-precision value)
    ret
