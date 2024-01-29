segment .data
    input_format db "%lf", 0
    input_format_n db "%d", 0
    output_format_n db "%d", 10, 0
    output_format db "Result: %lf", 10, 0

    COUNTER: dq 1
    FLAG: dq 1
    SUBTRACT: dq 1


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
    xor r14,r14


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
    
;    movsd xmm2, qword [rbp + rax]
;    movsd qword [result], xmm2
;
;    ; Print the result
;    mov rdi, output_format
;    movsd xmm0, qword [result]
;    call printf


    inc r14                            ;check condition for first loop to read columns(r14>n+1)
    cmp r14, [FLAG]
    jnz read_loop
loop1_condition:
    mov r14, 0
    inc r15
    cmp r15, [n]                       ;check condition for second loop to read rows(r15>n)
    jnz read_loop
end_read_loop:
    mov r15, [n]                       ;r15=n is counter for reading each row
    mov r14, [FLAG]                    ;r14=n is counter for reading each column

;    ; Store the result
;    mov byte [result], 55
;
;    ; Print the result
;    mov rdi, output_format_n
;    mov rsi, [result]
;    call printf
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
