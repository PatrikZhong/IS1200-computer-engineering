  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0, 17		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  		
  hexasc: 
  

	move $t1, $a0
	
	andi $t1, $t1, 0xF
	
	ble $t1, 9, greater
		
	addi $t1, $t1, 55
	
 	move $v0, $t1
 	
 	jr $ra
	
 greater: 
 	
 	
 	
 	addi $t1, $t1, 48
 		
	move $v0, $t1
	
	jr $ra
 	
 	
 	
 	
  	 
  #

