  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  		
  hexasc: 
  
	move $t1, $a0	
	andi $t1, $t1, 0xF	
	ble $t1, 9, greater	
	nop	
	addi $t1, $t1, 55	
 	move $v0, $t1 	
 	jr $ra	
 	nop
 greater: 
 	
 	addi $t1, $t1, 48 		
	move $v0, $t1	
	jr $ra
	nop
 
  
  
 time2string: 
 # ta de 4 f�rsta bitarna av sekunderna till plats 0.
 	PUSH $s0
 	move $s0, $a0 	#f�r att slippa pilla med a0
 	
 	andi $t0, $a1, 0xF  #f�rsta 4 bitarna
 	move $a0, $t0	#Omvandla med hexasc 	
 	PUSH $ra #Spara den "rena" ra
 	jal hexasc #anv�nd hexasc
 	nop
 	sb $v0, 4($s0) 	 #flytta svaret fr�n hexasc till s0 	
 	POP $ra #ta tillbaks den "rena" ra
 #ta n�sta 4 bitarna av sekunderna till plats 1
 	srl $a1, $a1, 4 #shifta till de relevanta bitarna 
 	andi $t0, $a1, 0xF #maska
 	move $a0, $t0	 #flyttar 	
 	PUSH $ra
 	jal hexasc
 	nop 
 	sb $v0, 3($s0) 	  	
 	POP $ra
 #resterande minut bitar
 	 	
 	srl $a1, $a1, 4
 	andi $t0, $a1, 0xF 
 	move $a0, $t0	 	
 	PUSH $ra
 	jal hexasc 
 	nop
 	sb $v0, 1($s0) 	  	
 	POP $ra
 	
 	srl $a1, $a1, 4
 	andi $t0, $a1, 0xF 
 	move $a0, $t0	 	
 	PUSH $ra
 	jal hexasc 
 	nop
 	sb $v0, 0($s0) 	  	
 	POP $ra 	
 	
 	#ladda in kolon och noll
 	li $t7, 58
 	sb $t7, 2($s0) 	
 	li $t8, 0 
 	sb $t9, 5($s0)
 	#Flytta ditt totala resultat till v0 som k�r, hoppa tillbaks till return adress.
 	
 	move $v0, $s0	
 	jr $ra
 	nop
 		
  #
  
  delay: 
  	li $a1, 1000 #loopargumentet f�r whileloopen
  	move $t1, $a1  	
  	li $t2, 500  #loopargumentet f�r forloopen
  	li $t3, 0
  		
 while:
 	ble $t1, 0, exit
 	addi $t1, $t1, -1 
 	
 	
  for :
  	addi $t3, $t3, 1 #l�gg till 1 i ditt whileloopsargument
  	
  	bne $t3, $t2, for
  	nop
  	li $t3, 0  
  	j while	
  	
  	nop
 exit: 	
  	jr $ra 
  	nop
  	
  
  	
  
  	
  	
  	
  	
  	
  	 
  
  
 
  

  #
