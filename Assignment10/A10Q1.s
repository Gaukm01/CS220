	.data

arr_asc:	.space 4000
message_0:	.asciiz "Element was not found"
message_1:	.asciiz "Found element at index "
message_2: .asciiz "Enter the length n of the array: "
message_3: .asciiz "Enter n integers in Ascending Order: "
message_4: .asciiz "Enter the element that you want to search: "
nLine: .asciiz "\n"

	.text
	.globl main



bsearch:  slt $t1,$a2,$a1
      beq $t1,$0,mid
      addi $v0,$0,-1
      jr $ra


mid:  add $t1,$a1,$a2
      srl $t1,$t1,1
      add $t2,$a0,$0
      sll $t3,$t1,2
      add $t3,$t3,$t2
      lw $t3,0($t3)
      bne $t3,$a3,right		   # checking mid
      add $v0,$t1,$0		     # if key = arr[mid]
      jr $ra				         # then return

right:  slt $t4,$t3,$a3	     # if mid < key then right else left will be executed
      beq $t4,$0,left
      addi $sp,$sp,-4
      sw $ra,0($sp)
      addi $a1,$t1,1	       # left = mid + 1
      jal bsearch			       # search right of arr
      lw $ra,0($sp)
      addi $sp,$sp,4
      jr $ra

left:  addi $sp,$sp,-4
      sw $ra,0($sp)
      addi $a2,$t1,-1  	    # right = mid - 1
      jal bsearch			      # search left of arr
      lw $ra,0($sp)
      addi $sp,$sp,4
      jr $ra



main:  la $a0, message_2
	   jal pString
     la $a0, nLine
	   jal pString
	   jal inInt

	   add $s0,$v0,$0
     add $t1,$v0,$0
     la $t2,arr_asc

	  la $a0, message_3
	  jal pString
	  la $a0, nLine
	  jal pString


arr_r_s:  li $v0,5
    syscall
    sw $v0,0($t2)
    addi $t2,$t2,4
    addi $t1,$t1,-1
    bne $t1,$0,arr_r_s			# inputting ascending array

	  la $a0, message_4
	  li $v0, 4
	  syscall
	  la $a0,nLine
	  li $v0,4
	  syscall
    li $v0,5			          # input key (element to be searched)
    syscall

    add $s1,$v0,$0
    addi $sp,$sp,-4

    sw $ra,0($sp)

    la $a0,arr_asc
    add $a1,$0,$0          # preparing arguements to call the bsearch function
    addi $a2,$s0,-1			   # a1 = left, a0 = array , a2 = right, a3 = mid
	  addi $a3,$s1,0

	  jal bsearch			       # calling bsearch to search for key
    lw $ra,0($sp)
    addi $sp,$sp,4

	  add $a0,$v0,$0
    slt $t1,$v0,$0

	  beq $t1,$0,fi_print		# if found then final messages and index will be printed

	  li $v0,4
    la $a0,message_0			# if not found then this will message will be printed
    syscall

	  jr $ra



pString: 	li $v0, 4
		syscall		          	#	Function that will print a string
		jr $ra


inInt: 		li $v0, 5
		syscall				        #	This Function will take an integer as input and then it will stored in $v0
		jr $ra

fi_print:  add $s0,$v0,$0
    li $v0,4
    la $a0,message_1	  	# found message printed
    syscall

    li $v0,1
    add $a0,$s0,$0		  	# printing index at which it is found
    syscall

    jr $ra
