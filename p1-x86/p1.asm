; to assemble and execute run:
;  nasm -f elf64 p1.asm
;  ld p1.o
;  ./a.out

section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .data
    carry: db 4         ; to store carry in adding
    array: db 100
    array2: db 100
    
    input_char: db 1
    formatin_c: db "%c", 0
    formatin_d: db "%d", 0
    formatout: db "%c", 0

    print_int_format: db        "%ld", 0
    read_int_format: db         "%ld", 0

section .text
    extern printf
    extern putchar
    extern puts
    extern scanf
    extern getchar
    global print_int
    global print_char
    global print_string
    global print_nl
    global read_int
    global read_char
    
    global asm_main
    

asm_main:
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    sub rsp, 8

    ; -------------------------

    call read_char
    mov r12, rax        ;r12 holds the operation

    xor r13, r13        ;r13 holds the number of digits of input1
    xor r15, r15        ;r15 holds the number of digits of input2
    lea r14, [array]    ;r14 is used to store the address of input1
    lea rbp, [array2]   ;rbp is used to store the address of input2

    call read_char      ;the new line character after the operation character

input_loop1:

    call read_char      ;main function

    cmp rax, 10
    je input_loop2x

    mov byte [r14], al

    inc r13
    add r14, 2

    jmp input_loop1

input_loop2x:
    ;sub r14, 2
    ;mov rdi, r14
    ;call print_int
    ;mov rdi, 10
    ;call print_char
    ;movzx rdi, byte [r14]
    ;call print_int
    ;call print_nl
    ;add r14, 2

input_loop2:
    mov rdi, r13
    call read_char      ;main function
    
    cmp rax, 10
    je end_loop

    mov byte [rbp], al

    inc r15
    add rbp, 2

    jmp input_loop2

end_loop:

    mov r9, '+'
    cmp r12, r9
    je add_section

    mov r9, '-'
    cmp r12, r9
    je subtract_section

    mov r9, '*'
    cmp r12, r9
    je multiply_section

    mov r9, '/'
    cmp r12, r9
    je divide_section

add_section:
    mov rax, 0
    mov byte[carry], al
    sub r14, 2
    sub rbp, 2

    ;mov rdi, r14
    ;call print_int
    ;call print_nl
    ;movzx rdi, byte [r14]
    ;call print_int
    ;call print_nl

    ;lea r14, [array]
    ;lea rbp, [array2]
    ;add r14, r13
    ;add r14, r13
    ;add r14, r15
    ;add r14, r15

add_loop:
    ;mov rdi, 100000
    ;call print_int
    ;call print_nl

    cmp r13, r15
    jg input1_is_bigger

    ;input2 is bigger or has the same size

    movzx r12, byte [r14]

    movzx rbx, byte [rbp]

    sub r12, 48
    sub rbx, 48
    add rbx, r12

    add bl, byte [carry]

    mov rax, 0
    mov byte [carry], al
    
    cmp rbx, 10

    jl we_dont_have_carry
    
    mov rax, 1
    mov byte [carry], al

    sub rbx, 10
    

we_dont_have_carry:
    add rbx, 48
    mov byte [rbp], bl

    cmp r14, array
    je print_add
    sub r14, 2
    sub rbp, 2
    jmp add_loop

print_add:
    lea r14, [array2]           ;for printing
    cmp rbp, array2
    je both_fininshed
    
last_carry_loop:
    sub rbp, 2
    movzx rax, byte [rbp]
    add al, byte [carry]
    mov rdx, 0
    mov byte [carry], dl
    cmp rax, 58
    jl continue
    mov rdx, 1
    mov byte [carry], dl
    sub rax, 10
    mov byte [rbp], al
    cmp rbp, array2
    je both_fininshed
    jmp last_carry_loop
    

continue:
    mov byte [rbp], al
    jmp output_loop

both_fininshed:
    cmp byte [carry], 0
    jg print_one
    jmp output_loop

print_one:
    mov rdi, '1'
    call print_char

output_loop:
    movzx rdi, byte [r14]
    call print_char
    add r14, 2
    dec r15
    cmp r15, 0
    jg output_loop
    jmp end


input1_is_bigger:
    movzx r12, byte [rbp]

    movzx rbx, byte [r14]

    sub r12, 48
    sub rbx, 48
    add rbx, r12

    add bl, byte [carry]

    mov rax, 0
    mov byte [carry], al
    
    cmp rbx, 10

    jl we_dont_have_carry_
    
    mov rax, 1
    mov byte [carry], al

    sub rbx, 10
    

we_dont_have_carry_:
    add rbx, 48
    mov byte [r14], bl



    cmp rbp, array2
    je print_add_
    sub r14, 2
    sub rbp, 2
    jmp add_loop

print_add_:
    lea rbp, [array]           ;for printing

last_carry_loop_:
    sub r14, 2
    movzx rax, byte [r14]
    add al, byte [carry]
    mov byte [r14], al
    cmp rax, 58
    jl continue_
    mov rdx, 1
    mov byte [carry], dl
    sub rax, 10
    mov byte [r14], al
    cmp r14, array
    je both_fininshed_
    jmp last_carry_loop_

continue_:
    mov byte [r14], al
    jmp output_loop_

both_fininshed_:
    cmp byte [carry], 0
    jg print_one_
    jmp output_loop_

print_one_:
    mov rdi, '1'
    call print_char

output_loop_:
    movzx rdi, byte [rbp]
    call print_char
    add rbp, 2
    dec r13
    cmp r13, 0
    jg output_loop_
    jmp end



subtract_section:
    sub r14, 2
    sub rbp, 2
    mov rax, 0
    mov byte [carry], al

    cmp r13, r15
    jg input1_greater
    jl input2_greater

    ;equal size
    lea r11, [array]
    lea r10, [array2]

compare_loop:
    movzx r9, byte [r11]
    movzx r8, byte [r10]
    cmp r9, r8
    jg input1_greater
    jl input2_greater

    cmp r11, r14
    je here
    add r11, 2
    add r10, 2
    jmp compare_loop
    
here:
    mov rdi, '0'
    call print_char
    jmp end

input1_greater:
    mov rax, 0
    mov byte [carry], al

sub_loop:
    movzx rbx, byte [r14]
    movzx r12, byte [rbp]
    

    ;sub rbx, 48
    sub r12, 48
    sub rbx, r12
    
    sub bl, byte [carry]
    mov rax, 0
    mov byte [carry], al

    cmp rbx, '0'
    
    jge no_carry

    mov rax, 1
    mov byte [carry], al
    add rbx, 10

no_carry:
    ;add rbx, 48
    mov byte [r14], bl
    cmp rbp, array2
    je print_sub
    sub r14, 2
    sub rbp, 2
    jmp sub_loop

print_sub:
    lea rbp, [array]        ;for printing

carry_loop:
    sub r14, 2
    movzx rax, byte [r14]
    sub al, byte [carry]
    mov rdx, 0
    mov byte [carry], dl
    cmp rax, 0
    jge continue3

    mov rdx, 1
    mov byte [carry], dl
    add rax, 10
    mov byte [r14], al
    jmp carry_loop


continue3:
    mov byte [r14], al
    movzx r8, byte [rbp]
    cmp r8, '0'
    jne output_loop2
    add rbp, 2
    dec r13
    jmp continue3

output_loop2:
    movzx rdi, byte [rbp]
    call print_char
    add rbp, 2
    dec r13
    cmp r13, 0
    jg output_loop2
    jmp end


input2_greater:
    mov rax, 0
    mov byte [carry], al
    mov rdi, '-'
    call print_char

sub_loop2:
    movzx rbx, byte [rbp]
    movzx r12, byte [r14]

    ;sub rbx, 48
    sub r12, 48
    sub rbx, r12
    sub bl, byte [carry]
    mov rax, 0
    mov byte [carry], al

    cmp rbx, '0'
    jge no_carry2
    mov rax, 1
    mov byte [carry], al
    add rbx, 10

no_carry2:
    ;add rbx, 48
    mov byte [rbp], bl
    cmp r14, array
    je print_sub2
    sub r14, 2
    sub rbp, 2
    jmp sub_loop2

print_sub2:
    lea r14, [array2]        ;for printing

carry_loop2:
    sub rbp, 2
    movzx rax, byte [rbp]
    sub al, byte [carry]
    mov rdx, 0
    mov byte [carry], dl
    cmp rax, 0
    jge continue2

    mov rdx, 1
    mov byte [carry], dl
    add rax, 10
    mov byte [rbp], al
    jmp carry_loop2


continue2:
    mov byte [rbp], al

    movzx r8, byte [r14]
    cmp r8, '0'
    jne output_loop3
    add r14, 2
    dec r15
    jmp continue2

output_loop3:
    movzx rdi, byte [r14]
    call print_char
    add r14, 2
    dec r15
    cmp r15, 0
    jg output_loop3
    jmp end

multiply_section:

divide_section:

end:
    ;--------------------------

    add rsp, 8

  pop r15
  pop r14
  pop r13
  pop r12
    pop rbx
    pop rbp

  ret




print_int:
    sub rsp, 8

    mov rsi, rdi

    mov rdi, print_int_format
    mov rax, 1 ; setting rax (al) to number of vector inputs
    call printf
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_char:
    sub rsp, 8

    call putchar
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_string:
    sub rsp, 8

    call puts
    
    add rsp, 8 ; clearing local variables from stack

    ret


print_nl:
    sub rsp, 8



    mov rdi, 10
    call putchar
    
    add rsp, 8 ; clearing local variables from stack

    ret


read_int:
    sub rsp, 8

    mov rsi, rsp
    mov rdi, read_int_format
    mov rax, 1 ; setting rax (al) to number of vector inputs
    call scanf

    mov rax, [rsp]

    add rsp, 8 ; clearing local variables from stack

    ret


read_char:
    sub rsp, 8

    call getchar

    add rsp, 8 ; clearing local variables from stack

    ret