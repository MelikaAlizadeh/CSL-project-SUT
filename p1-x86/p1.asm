; to assemble and execute run:
;  nasm -f elf64 p1.asm
;  ld p1.o
;  ./a.out

section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    mul_res resb 200
    temp resb 200
    array resb 200
    array2 resb 200
    div_res resb 200


section .data
    carry: db 0         ; to store carry in adding
    carry2: db 0
    sign1: db 0
    sign2: db 0
    size1: db 0
    np: db 4
    
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
main_loop:
    call read_char
    mov r12, rax        ;r12 holds the operation
    cmp r12, 'q'
    je the_end

    xor r13, r13        ;r13 holds the number of digits of input1
    xor r15, r15        ;r15 holds the number of digits of input2
    lea r14, [array]    ;r14 is used to store the address of input1
    lea rbp, [array2]   ;rbp is used to store the address of input2

    call read_char      ;the new line character after the operation character

    xor rdx, rdx
    mov rdx, 0
    mov byte [np], dl

    xor rdx, rdx
    mov rdx, '+'
    mov byte [sign1], dl
input_loop1:

    call read_char      ;main function

    cmp rax, 10
    je input_loop2x
    
    cmp rax, '-'
    jne a
    xor rdx, rdx
    mov rdx, '-'
    mov [sign1], dl
    jmp input_loop1

a:
    mov byte [r14], al

    inc r13
    mov rax, r13
    mov byte [size1], al
    add r14, 2

    jmp input_loop1

input_loop2x:
    xor rdx, rdx
    mov rdx, '+'
    mov byte [sign2], dl

input_loop2:
    mov rdi, r13
    call read_char      ;main function

    cmp rax, '-'
    jne b
    xor rdx, rdx
    mov rdx, '-'
    mov [sign2], dl
    jmp input_loop2

b:
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

    mov r9, '%'
    cmp r12, r9
    je mod_section

add_section:

    movzx r10, byte [sign1]
    cmp r10, '-'
    je negative
    ;input1 possitive
    movzx r10, byte [sign2]
    cmp r10, '-'
    je do_the_sub
    ;pp
    jmp do_the_adding

negative:
    movzx r10, byte [sign2]
    cmp r10, '-'
    je nn
    ;np
    mov rdx, 1
    mov byte [np], dl
    jmp do_the_sub
    
nn:
    mov rdi, '-'
    call print_char


do_the_adding:
    mov rax, 0
    mov byte[carry], al
    sub r14, 2
    sub rbp, 2

add_loop:
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

    movzx r10, byte [sign1]
    cmp r10, '-'
    je negativ
    ;input1 possitive
    movzx r10, byte [sign2]
    cmp r10, '-'
    je do_the_adding
    ;pp
    jmp do_the_sub

negativ:
    movzx r10, byte [sign2]
    cmp r10, '-'
    je nn2
    ;np
    mov rdi, '-'
    call print_char
    jmp do_the_adding
    
nn2:
    mov rdx, 1
    mov byte [np], dl
    
do_the_sub:

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
    cmp byte [np], 1
    jne c
    mov rdi, '-'
    call print_char

c:
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
    cmp byte [np], 1
    je sub_loop2
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

    
    ;put '0' in all the indexes of mul_res
    mov r8, 200
    lea r9, [mul_res]
put_zero:
    mov rax, '0'
    mov byte [r9], al
    dec r8
    cmp r8, 0
    je after_zero
    add r9, 1
    jmp put_zero

after_zero:
    
    lea rbp, [array2]
    add rbp, r15
    add rbp, r15
    sub rbp, 2

    lea r9, [mul_res]
    add r9, 199

mul_loop1:

    ;print zero if the second input is zero
    lea r14, [array2]
    movzx rax, byte [r14]
    cmp rax, '0'
    je print_zero

    ;put '0' in all indexes of temp
    lea r10, [temp]
    mov r8, 200

    put_zero3:
        mov rax, '0'
        mov byte [r10], al
        dec r8
        cmp r8, 0
        je after_zero3
        add r10, 1
        jmp put_zero3

    after_zero3:
    lea r8, [temp]
    add r8, 199

    movzx r13, byte [size1]
    lea r14, [array]
    add r14, r13
    add r14, r13
    sub r14, 2

    mov rax, 0
    mov byte [carry], al
    
    add r8, 1

    mul_loop2:
        sub r8, 1
        movzx rbx, byte [rbp]
        movzx r12, byte [r14]
        
        sub rbx, 48
        sub r12, 48
        
        imul rbx, r12
        movzx rax, byte [carry]
        add rbx, rax

        cmp rbx, 10
        jl after_carry

        handle_carry:
            movzx rax, byte [carry]
            add rax, 1
            mov byte [carry], al
            sub rbx, 10
            cmp rbx, 10
            jge handle_carry
            jmp after_carry

        after_carry:       ;now we have saved the first digit of the multiplication result in rbx and the second one in [carry].
        
        ;add rbx to temp
        mov r10, r8
        movzx rdx, byte [r10]
        add rdx, rbx
        cmp rdx, 58
        jl no_carry4
        
        movzx rax, byte [carry]
        add rax, 1
        mov byte [carry], al
        sub rdx, 10
        
        no_carry4:
        mov byte [r10], dl
        

        sub r10, 1
    loop1:                          ;for passing carry to the other digits of temp
        movzx rdx, byte [r10]
        movzx rbx, byte [carry]
        
        add rdx, rbx
        mov rax, 0
        mov byte [carry], al
        cmp rdx, 58
        jl no_carry3

        ;carry = 1
        mov rax, 1
        mov byte [carry], al

        sub rdx, 10
        mov byte [r10], dl
        sub r10, 1
        jmp loop1

        no_carry3:
        mov byte [r10], dl

        ;end_of_loop1

        cmp r14, array
        je first_input_finished
        sub r14, 2
        jmp mul_loop2

    first_input_finished:

        ;lea r14, [temp]
        ;mov r15, 200
        ;ll:
        ;movzx rdi, byte [r14]
        ;call print_char
        ;add r14, 1
        ;dec r15
        ;cmp r15, 0
        ;jg ll


        ;add temp to mul_res

        mov rax, 0
        mov byte [carry2], al
        mov r10, r9                 ;at first r9 = mul_res + 199
        lea r8, [temp]
        add r8, 199
    
        add_loop3:
            movzx r12, byte [r8]
            movzx rbx, byte [r10]
            
            sub r12, 48
            sub rbx, 48
            add rbx, r12

            add bl, byte [carry2]

            mov rax, 0
            mov byte [carry2], al

            cmp rbx, 10
            jl we_dont_have_carry3

            mov rax, 1
            mov byte [carry2], al
            sub rbx, 10

        we_dont_have_carry3:
            add rbx, 48
            mov byte [r10], bl

            cmp r8, temp
            je add_finished
            sub r8, 1
            sub r10, 1
            jmp add_loop3
        
        add_finished:

        lea r8, [temp]
        add r8, 199

        cmp rbp, array2
        je multiply_finished
        sub rbp, 2
        sub r9, 1
        jmp mul_loop1

        multiply_finished:
            lea r14, [mul_res]
            mov r13, 200
        l3:
            movzx r8, byte [r14]
            cmp r8, 0
            je print_zero
            cmp r8, '0'
            jne handle_sign
            add r14, 1
            dec r13
            jmp l3
        
        handle_sign:
            movzx rax, byte [sign1]
            cmp rax, '-'
            je firs_negative
            movzx rax, byte [sign2]
            cmp rax, '-'
            jne print_loop
            jmp print_neg
        firs_negative:
            movzx rax, byte [sign2]
            cmp rax, '-'
            je print_loop
        print_neg:
            mov rdi, '-'
            call print_char

        print_loop:
            movzx rdi, byte [r14]
            call print_char
            add r14, 1
            dec r13
            cmp r13, 0
            jg print_loop
            jmp end


divide_section:
    movzx r10, byte [sign1]
    cmp r10, '-'
    je a_neg2
    movzx r10, byte [sign2]
    cmp r10, '-'
    je print_negative2
    jmp do_nothing2
a_neg2:
    movzx r10, byte [sign2]
    cmp r10, '-'
    je do_nothing2

print_negative2:
    mov rdi, '-'
    call print_char


do_nothing2:
    ;put '0' in all the indexes of div_res and '0' and '-1' in the first one
    mov r8, 199
    lea r14, [div_res]
put_zero2:
    mov rax, '0'
    mov byte [r14], al
    dec r8
    cmp r8, 0
    je after2
    add r14, 1
    jmp put_zero2
after2:
    add r14, 1
    mov rax, 47
    mov byte [r14], al

    mov rax, r13
    mov byte [size1], al
    
div_loop:
    ;adding_part
    lea r9, [div_res]
    add r9, 199
    
    movzx rbx, byte [r9]
    add rbx, 1
    
    cmp rbx, 58
    jl there_is_no_carry
    sub rbx, 10
    mov byte [r9], bl
    jmp carry_loop4
there_is_no_carry:
    mov byte [r9], bl
    jmp after_adding

carry_loop4:
    sub r9, 1
    movzx rax, byte [r9]
    add rax, 1
    cmp rax, 58
    jl continue4
    sub rax, 10
    mov byte [r9], al
    jmp carry_loop4
    
continue4:
    mov byte [r9], al

after_adding:

    lea r14, [array]
    movzx r13, byte [size1]

    lea r14, [array]
    lea rbp, [array2]
    add r14, r13
    add r14, r13
    sub r14, 2
    add rbp, r15
    add rbp, r15
    sub rbp, 2


    lea r11, [array]
    lea r10, [array2]
    mov rax, 0
    mov byte [carry], al
    
;this loop is for removing the first zeros of the number
lop2:
    movzx r8, byte [r11]
    cmp r8, '0'
    jg x2
    dec r13
    add r11, 2
    jmp lop2
x2:
    cmp r13, r15
    jg subtract2
    jl print_result


    ;equal size
compare_loop3:
    movzx r9, byte [r11]
    movzx r8, byte [r10]
    cmp r9, r8
    jg subtract2
    jl print_result

    cmp r11, r14
    je equal2
    add r11, 2
    add r10, 2
    jmp compare_loop3

equal2:
    ;adding part
    lea r9, [div_res]
    add r9, 199
    movzx rbx, byte [r9]
    add rbx, 1
    cmp rbx, 58
    jge before_carry
    mov byte [r9], bl
    jmp after_adding2

before_carry:
    sub rbx, 10
    mov byte [r9], bl

carry_loop5:
    sub r9, 1
    movzx rax, byte [r9]
    add al, 1
    cmp rax, 58
    jl continue5
    sub rax, 10
    mov byte [r9], al
    jmp carry_loop5
    
continue5:
    mov byte [r9], al
after_adding2:


print_result:
    lea r14, [div_res]
    mov r13, 200
l2:
    movzx r8, byte [r14]
    cmp r8, 0
    je print_zero
    cmp r8, '0'
    jne output_lop
    add r14, 1
    dec r13
    jmp l2

output_lop:
    movzx rdi, byte [r14]
    call print_char
    add r14, 1
    dec r13
    cmp r13, 0
    jg output_lop
    jmp end

print_zero:
    mov rdi, 0
    call print_int
    jmp end

subtract2:
    mov rax, 0
    mov byte [carry], al

subt_loop2:
    movzx rbx, byte [r14]
    movzx r12, byte [rbp]

    sub r12, 48
    sub rbx, r12
    
    sub bl, byte [carry]
    mov rax, 0
    mov byte [carry], al

    cmp rbx, '0'
    
    jge no_carryy2

    mov rax, 1
    mov byte [carry], al
    add rbx, 10

no_carryy2:
    mov rdi, rbx
    mov byte [r14], bl
    cmp rbp, array2
    je carry_loop3
    sub r14, 2
    sub rbp, 2
    jmp subt_loop2

carry_loop3:
    cmp r14, array
    je div_loop                     ;there is no carry
    sub r14, 2
    movzx rax, byte [r14]
    sub al, byte [carry]
    mov rdx, 0
    mov byte [carry], dl
    
    cmp rax, '0'
    jge z2
    
    mov rdx, 1
    mov byte [carry], dl
    add rax, 10
    mov byte [r14], al
    jmp carry_loop3
z2:
    mov byte [r14], al
    jmp div_loop





mod_section:
    
    mov rax, r13
    mov byte [size1], al
    
mod_loop:

    lea r14, [array]
    movzx r13, byte [size1]

    lea r14, [array]
    lea rbp, [array2]
    add r14, r13
    add r14, r13
    sub r14, 2
    add rbp, r15
    add rbp, r15
    sub rbp, 2

    lea r11, [array]
    lea r10, [array2]
    mov rax, 0
    mov byte [carry], al
    

lop:
    movzx r8, byte [r11]
    cmp r8, '0'
    jg x
    dec r13
    cmp r13, 0
    je equal
    add r11, 2
    jmp lop
x:
    cmp r13, r15
    jg subtract
    jl print_input1


    ;equal size
compare_loop2:
    movzx r9, byte [r11]
    movzx r8, byte [r10]
    cmp r9, r8
    jg subtract
    jl print_input1

    cmp r11, r14
    je equal
    add r11, 2
    add r10, 2
    jmp compare_loop2
    
equal:
    mov rdi, '0'
    call print_char
    jmp end


print_input1:
    movzx r10, byte [sign1]
    cmp r10, '-'
    jne edame
    mov rdi, '-'
    call print_char
edame:
    ;mov rdi, r13
    ;call print_int
    lea r14, [array]
    movzx r13, byte [size1]
l:
    movzx r8, byte [r14]
    cmp r8, '0'
    jne output_loopp
    add r14, 2
    dec r13
    jmp l

output_loopp:
    movzx rdi, byte [r14]
    call print_char
    add r14, 2
    dec r13
    cmp r13, 0
    jg output_loopp
    jmp end


subtract:
    mov rax, 0
    mov byte [carry], al

subt_loop:
    movzx rbx, byte [r14]
    movzx r12, byte [rbp]

    sub r12, 48
    sub rbx, r12
    
    sub bl, byte [carry]
    mov rax, 0
    mov byte [carry], al

    cmp rbx, '0'
    
    jge no_carryy

    mov rax, 1
    mov byte [carry], al
    add rbx, 10

no_carryy:
    mov rdi, rbx
    mov byte [r14], bl
    cmp rbp, array2
    je carry_loop22
    sub r14, 2
    sub rbp, 2
    jmp subt_loop

carry_loop22:
    cmp r14, array
    je mod_loop                     ;there is no carry
    sub r14, 2
    movzx rax, byte [r14]
    sub al, byte [carry]
    mov rdx, 0
    mov byte [carry], dl
    
    cmp rax, '0'
    jge z
    
    mov rdx, 1
    mov byte [carry], dl
    add rax, 10
    mov byte [r14], al
    jmp carry_loop22
z:
    mov byte [r14], al
    jmp mod_loop

end:
    mov rdi, 10
    call print_char
    jmp main_loop
the_end:
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
