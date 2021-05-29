        .data                       # the data segment of our program
msg1:	.asciiz ", "                # string to print semicolon after our every fiboonaaci number
msg2:   .asciiz "Enter the value of N \n"  # just to make our output more aesthetic!


        .text                       # code section
        .globl main


fibo:	slti $t1,$a0,2             # base case of recursive function, when the last one element that is 1 is there
		beq $t1,$0,label            # if its not a base case then jump on to the recursive part again.
		addi $v0,$0,1               # else return 1 as the base case number.
		jr $ra                      # return to main function to sum that number


label:	addi $sp,$sp,-4         # decreasing stack pointer by 4 to make room to store one return address.
		sw $ra,0($sp)               # storing the return address to stack.
		addi $sp,$sp,-4
		sw $a0,0($sp)               # storing this is in stack so, as to use it later while backtracing.
		addi $a0,$a0,-1             # now decrement the number by one to call the fibo function recursively.

		jal fibo                    # calling fib to get n-1 fib number

		add $t1,$v0,$0              # saving result of n-1 th fibonacci number in t1
		lw $a0,0($sp)               # now again saving the original n in a0
		addi $sp,$sp,-4             # decrementing stack pointer to store one more integer
		sw $t1,0($sp)               # storing n-1th fib number in stack
		addi $a0,$a0,-2             # now decreasing the arguement by 2 to find n-2th fibonacci number

		jal fibo                    # calling function fibo to get  the n-2th fib number

		lw $t1,0($sp)               # storing n-1th fibonacci number in t1
		addi $sp,$sp,8              # removing last two arguements from the stack of n-1th number and n value
		lw $ra,0($sp)               # now getting back the return address in the ra register from stack.
		addi $sp,$sp,4              # now removing all the values from stack , that we stored during this function.
		add $v0,$t1,$v0             # adding n-1th and n-2th fibonaaci number

		jr $ra                      # return to caller function.


main:   la $a0,msg2                 # printing message 2
    syscall                     # to print string
    li $v0,5                    # to input an integer
		syscall                     # to read int

		add $s2,$v0,$0              # storing N in s2
		add $s1,$0,$0               # storing 0 in s1
		blez $s2,exit               # if N is <=0 then we quit the program.

loop:	addi $sp,$sp,-4         # to store return address in stack
    sw $ra,0($sp)           # storing return address in stack
    add $a0,$s1,$0          # initialising loop variable a0 to 0
    jal fibo                # calling fibo function to get first number
    add $a0,$v0,$0          # storing 1st number in a0.
    li $v0,1                # to load 1 into v0 to print int .
    syscall

    lw $ra,0($sp)           # to get back return address in ra
    addi $sp,$sp,4          # removing ra from stack.
    addi $s1,$s1,1          # Incrementing loop variable by 1
    beq $s1,$s2,exit        # if i==N then we exit. break from loop (breaking condition)
    li $v0,4                # to print string code
    la $a0,msg1             # printing semicolon
    syscall

    j loop                  # used unconditional jump to reiterate the loop.
    slt $t1,$s1,$s2         # checking if loop condition is satisfied , i.e, i<N
    bne $t1,$0,loop         # if it is satisfied then we continue the loop or else we exit

exit:	jr $ra                      # return to function which calls main
