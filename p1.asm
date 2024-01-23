; to assemble and execute run:
;  nasm -f elf64 first.asm
;  ld first.o
;  ./a.out



section .data
    buffer: db 5 ; buffer to store the read character

section .text
    global _start

_start:
    call read_char
    call print_char

    call read_char
    call print_char
    
    call read_char
    call print_char

    ; Exit the program
    mov rax, 60        ; System call number for sys_exit
    xor rdi, rdi       ; Exit code 0
    syscall 




read_char:
    ; System call number for sys_read is 0
    mov rax, 0

    ; File descriptor for standard input (stdin) is 0
    mov rdi, 0

    ; Buffer address
    mov rsi, buffer

    ; Number of bytes to read
    mov rdx, 1

    ; Invoke the system call
    syscall

    ret ; Return from the read_char function

    ; Now, the character is in the buffer
    ; You can use it as needed


print_char:
    ; System call number for sys_write is 1
    mov rax, 1

    ; File descriptor for standard output (stdout) is 1
    mov rdi, 1

    ; Character address
    mov rsi, buffer

    ; Character length (1 byte)
    mov rdx, 1

    ; Invoke the system call
    syscall

    ret ; Return from the print_char function



