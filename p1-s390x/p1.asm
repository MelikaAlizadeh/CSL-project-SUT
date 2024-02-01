.data
	print_int_format:  .asciz "%ld"
    print_uint_format: .asciz "%u"
	print_double_format:  .asciz "%lf"
    read_int_format:   .asciz "%ld"
    read_uint_format:  .asciz "%u"
    read_char_format:   .asciz "%c"
    read_double_format:   .asciz "%lf"
dc:
	array: .zero 100
	array2: .zero 100
	div_res: .zero 200
	carry: .zero 8
	sign1: .zero 8	
	sign2: .zero 8
	size1: .zero 8
	np: .zero 8
	np: .zero 8
	np: .zero 8
	np: .zero 8

.text
.globl asm_main
.globl print_int
.globl print_char
.globl print_nl
.globl print_space
.globl print_string
.globl print_double
.globl read_int
.globl read_uint
.globl read_char
.globl read_double


	print_int:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        lr      %r3,  %r2
        larl    %r2,  print_int_format
        brasl   %r14, printf
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


    print_uint:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        lr      %r3,  %r2
        larl    %r2,  print_uint_format
        brasl   %r14, printf
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


    print_char:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


    print_nl:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  10
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_space:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  32
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14

	
    print_string:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        brasl   %r14, puts
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_double:
		stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        larl    %r2,  print_double_format
        brasl   %r14, printf
		lay     %r15, 168(%r15)
		lg      %r14, -8(%r15)
        br      %r14	


    read_int:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        lay     %r3,  0(%r15)
        larl    %r2,  read_int_format
        brasl   %r14, scanf
		l       %r2,  0(%r15)
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


    read_uint:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        lay     %r3,  0(%r15)
        larl    %r2,  read_uint_format
        brasl   %r14, scanf
		l       %r2,  0(%r15)
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)


    read_char:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
        lay     %r3,  0(%r15)
        larl    %r2,  read_char_format
        brasl   %r14, scanf
		l       %r2,  0(%r15)
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	read_double:
		stg     %r14, -8(%r15)
        lay     %r15, -168(%r15)
        larl    %r2,  read_double_format
        brasl   %r14, scanf
		lay     %r15, 168(%r15)
		lg      %r14, -8(%r15)
        br      %r14	
 




    asm_main:
	stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
	
	brasl %r14, read_char	

    lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
    br      %r14


