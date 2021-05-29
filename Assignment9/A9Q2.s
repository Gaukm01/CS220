.data
A:        .space 60               #array space for vector A
B:        .space 60               #array space for vector B
msg1:    .asciiz "Enter n:\n"
msg2:    .asciiz "Enter n elements of A:\n"
msg3:    .asciiz "Enter n elements of B:\n"
msgo:    .asciiz "Output Vector Dot Product Sum: "

          .text
          .globl main
main:     li $v0 4              # syscall 4 (print_string)
          la $a0 msg1           # load addr of msg1
          syscall               # output msg1
          li $v0 5              # syscall 5 (read_int) read n
          syscall               # read integer and store to $v0
          add $t0 $0 $v0        # stores value of n in $t0

          li $t1 0              # make $t1 0 use as counter later
          la $s1 A              # load address of A in $s1
          li $v0 4              # syscall 4 (print_string)
          la $a0 msg2           # load addr of msg2
          syscall               # output msg1

loop1:    li $v0 6              # syscall 6 (read_float)
          syscall               # float value in $f0
          s.s $f0 0($s1)        # stores $f0 in array A space
          addi $s1 $s1 4        # $s1 = $s1 + 4  next element space of A
          addi $t1 $t1 1        # increment the counter by 1
          bne $t1 $t0 loop1     # jump back to loop1 if counter != n

          li $t1 0              # remake $t1 0 use as counter later
          la  $s2 B             # load address of B in $s2
          li $v0 4              # syscall 4 (print_string)
          la $a0 msg3           # load addr of msg1
          syscall               # output msg3

loop2:    li $v0 6              # syscall 6 (read_float)
          syscall               # float value in $f0
          s.s $f0 0($s2)        # stores $f0 in array B space
          addi $s2 $s2 4        # $s2 = $s2 + 4  next element space of B
          addi $t1 $t1 1        # increment the counter by 1
          bne $t1 $t0 loop2     # jump back to loop2 if counter != n

          xor $v0 $v0 $v0       # initialise $v0 to 0
          mtc1 $v0 $f12         # move $v0 (0) to $f12 (store final sum ans) to make $f12 0.00..
          la $s1 A              # re-load address of A in $s1
          la $s2 B              # re-load address of B in $s2
          li $t1 0              # make counter again 0

loop3:    l.s $f1 0($s1)        # load float a_i ith element of vec A
          l.s $f2 0($s2)        # load float b_i ith element of vec B
          mul.s $f3 $f1 $f2     # store value of a_i * b_i in $f3
          add.s $f12 $f12 $f3   # increment $f12 (storing ans) by a_i*b_i
          addi $t1 $t1 1        # increment counter by 1
          addi $s1 $s1 4        # $s1 = $s1 + 4  next element space of A
          addi $s2 $s2 4        # $s2 = $s2 + 4  next element space of B
          bne $t1 $t0 loop3     # jump back to loop3 if counter != n


          li $v0 4              # syscall 4 (print_string)
          la $a0 msgo           # load addr of msgo
          syscall               # output msgo
          li $v0 2              # syscall 2 (print_float)
          syscall               # print value at $f12
          jr $ra                # return back to caller
