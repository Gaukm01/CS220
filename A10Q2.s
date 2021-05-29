.data
A:        .space 60               #array space for vector A
msg1:    .asciiz "Enter n:\n"
msg2:    .asciiz "Enter n elements of A:\n"
msgo:    .asciiz "Output Required Sum: "

          .text
          .globl main

main:     li $v0 4              # syscall 4 (print_string)
          la $a0 msg1           # load addr of msg1
          syscall               # output msg1
          li $v0 5              # syscall 5 (read_int) read n
          syscall               # read integer and store to $v0
          add $t0 $0 $v0        # stores value of n in $t0

          li $t1 0              # make $t1 0 use as counter later
          la $s0 A              # load address of A in $s0 : 0($s0) will have a_0
          li $v0 4              # syscall 4 (print_string)
          la $a0 msg2           # load addr of msg2
          syscall               # output msg1

loop1:    li $v0 6              # syscall 6 (read_float)
          syscall               # float value in $f0
          s.s $f0 0($s0)        # stores $f0 in array A space
          addi $s0 $s0 4        # $s0 = $s0 + 4  next element space of A
          addi $t1 $t1 1        # increment the counter by 1
          bne $t1 $t0 loop1     # jump back to loop1 if counter != n

          li $t5 0              # initialise $t5 to 0 just to pass to $f12
          mtc1 $t5 $f12         # move $t5 (0) to $f12 (store final sum ans) to make $f12 0.00..
          li $t1 0              # making counter = 0
          li $t2 2              # storing 2 for finding wether i is odd or even
          la $s0 A              # getting starting point of Array space A, containing A_0


loop2:    l.s $f1 0($s0)        #load float a_i
          li $t3 0              # making $t3 0 for storing remainder of division
          div $t1 $t2           # now hi and lo have remainder and quotient of $t1/$t2 i.e. i/2
          mfhi $t3              # getting remainder in $t3
          bne $t3 $0 decr       # when i is odd, then subtract value of a_i as (-1)^i = -1
          add.s $f12 $f12 $f1   # add a_i when i = even
          j next
decr:     sub.s $f12 $f12 $f1   # odd i subtracting a_i
next:     addi $s0 $s0 4        # increment by 4 to go from a_i+1 to a_i
          addi $t1 $t1 1        # counter ++
          bne $t1 $t0 loop2       # jump back to loop2 if not counter < n,finishses at $t1 = n

          li $v0 4              # syscall 4 (print_string)
          la $a0 msgo           # load addr of msgo
          syscall               # output msgo
          li $v0 2              # syscall 2 (print_float)
          syscall               # print value at $f12
          jr $ra                # return back to caller
