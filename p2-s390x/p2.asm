.data
	print_int_format:  .asciz "%d"
    print_uint_format: .asciz "%u"
	print_double_format:  .asciz "%.3lf"
    read_int_format:   .asciz "%d"
    read_uint_format:  .asciz "%u"
    read_double_format:   .asciz "%lf"
dc:
	matrix: .zero 8008000
	n: .zero 8
	m: .zero 8	
	num1: .zero 8
	num2: .zero 8
	num3: .zero 8
	num4: .zero 8

.text
.globl asm_main
.globl print_int
.globl print_char
.globl print_nl
.globl print_space
.globl print_I
.globl print_m
.globl print_p
.globl print_o
.globl print_s
.globl print_i
.globl print_b
.globl print_l
.globl print_e
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


	print_I:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  73
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_m:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  109
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_p:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  112
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_o:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  111
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_s:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  115
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_i:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  105
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_b:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  98
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_l:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  108
        brasl   %r14, putchar
		lay     %r15, 8(%r15)
		lg      %r14, -4(%r15)
        br      %r14


	print_e:
		stg     %r14, -4(%r15)
        lay     %r15, -8(%r15)
		la      %r2,  101
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
        brasl   %r14, getchar
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
	
	# ---------------------------	
	brasl %r14, read_int
	larl %r13, n							#store n in memory (n is number of rows)
	stg %r2, 0(%r13)						

	aghi %r2, 1								#store m=n+1 in memory (m is number of columns)
	larl %r13, m
	stg %r2, 0(%r13)

	#larl %r13, n
	#lg %r2, 0(%r13)
	#brasl %r14, print_int

	lghi %r6, 0
	lghi %r7, 0
read_loop:
	larl %r12, matrix						#store the address of matrix in r12
	brasl %r14, read_double					#read matrix and vector of results
	larl %r13, num1
	std %f0, 0(%r13)

	#store numbers in matrix
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r7								#row * columns
	agr %r9, %r6							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9
	#store the result						#the offset is in r9
	larl %r13, num1							
	ld %f0, 0(%r13)
	agr %r12, %r9							#add offset
	std %f0, 0(%r12)						#store num1 in matrix


	larl %r13, m							#check condition for first loop to read columns (%r6>n+1)
	aghi %r6, 1	
	cg %r6, 0(%r13)
	jl read_loop
	
	lghi %r6, 0								#check condition for second loop to read rows (%r7>n)
	larl %r13, n
	aghi %r7, 1
	cg %r7, 0(%r13)
	jl read_loop
	
	lghi %r6, 0								#r6=n is counter for reading each column
	lghi %r7, 0								#r7=n is counter for reading each row



elimination:
	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r7								#row * columns
	agr %r9, %r7							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9


	agr %r12, %r9
	ld %f0, 0(%r12)							#load one num of matrix
	lghi %r3, 0
	cdfbr %f2, %r3							#see if diagonal contains any 0 then there is no answer
	kdbr %f0, %f2
	je end_if


	ld %f4, 0(%r12)							#now f4 is divisor
	larl %r13, num3							
	std %f4, 0(%r13)
	lghi %r6, 0								#r6=n is counter for reading each column
second_loop:
	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r7								#row * columns
	agr %r9, %r6							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9

	agr %r12, %r9							#set diagonal elements 1
	ld %f0, 0(%r12)	
	larl %r13, num3							
	ddb %f0, 0(%r13)
	std %f0, 0(%r12)						

	larl %r13, m							#check condition for loop to read columns (%r6>n+1)
	aghi %r6, 1	
	cg %r6, 0(%r13)
	jl second_loop


	lghi %r10, 0
others_loop:								#to eliminate other elements in the current column
	cr %r10, %r7
	je check

	lghi %r6, 0								#third loop counter
	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r10								#row * columns
	agr %r9, %r7							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9

	
	agr %r12, %r9
	ld %f4, 0(%r12)							#load one num of matrix
	larl 13, num2
	std %f4, 0(%r13)
third_loop:									#to perform matrix[k][j] -= factor * matrix[i][j];
	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r7								#row * columns
	agr %r9, %r6							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9

	agr %r12, %r9
	larl 13, num2
	ld %f4, 0(%r13)							#set diagonal elements 1
	mdb %f4, 0(%r12)

	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r10								#row * columns
	agr %r9, %r6							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9

	larl 13, num4
	std %f4, 0(%r13)
	agr %r12, %r9
	ld %f6, 0(%r12)
	larl 13, num4
	sdb %f6, 0(%r13)
	std %f6, 0(%r12)

	larl %r13, m
	aghi %r6, 1	
	cg %r6, 0(%r13)
	jl third_loop
check:
	lghi %r6, 0
	larl %r13, n
	aghi %r10, 1	
	cg %r10, 0(%r13)
	jl others_loop

end_check:
	larl %r13, n
	aghi %r7, 1
	cg %r7, 0(%r13)
	jl elimination

print_section:
	lghi %r7, 0
	larl %r13, n
	lg %r6, 0(%r13)
print_loop:
	larl %r12, matrix						#store the address of matrix in r12
	larl %r13, m							#load number of columns in r9
	lg %r9, 0(%r13)	
	lghi %r8, 0								#r8=0
	mr %r8, %r7								#row * columns
	agr %r9, %r6							#(row * columns) + column
	lghi %r5, 8							#r10=8 (size of double-precision value)
	mr %r8, %r5							#((row * columns) + column) * 8 --> r9

	agr %r12, %r9
	ld %f0, 0(%r12)
	brasl %r14, print_double
	brasl %r14, print_space

	larl %r13, n
	aghi %r7, 1
	cg %r7, 0(%r13)
	jl print_loop

	j end_all








end_if:										#there is no solution
	brasl %r14, print_I
	brasl %r14, print_m
	brasl %r14, print_p
	brasl %r14, print_o
	brasl %r14, print_s
	brasl %r14, print_s
	brasl %r14, print_i
	brasl %r14, print_b
	brasl %r14, print_l
	brasl %r14, print_e
	j end_all

end_all:
	brasl %r14, print_nl	
	# ---------------------------	

    lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
    br      %r14


