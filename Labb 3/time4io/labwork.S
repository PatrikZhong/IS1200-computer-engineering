  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
	
.endm

.globl time2string
.globl delay

.data
.align 2
.text
  #
  # Please add your own code below this line
  time2string: 
 # ta de 4 första bitarna av sekunderna till plats 0.
 	PUSH $s0
 	move $s0, $a0 	#för att slippa pilla med a0
 	
 	andi $t0, $a1, 0xF  #första 4 bitarna
 	move $a0, $t0	#Omvandla med hexasc 	
 	PUSH $ra #Spara den "rena" ra
 	jal hexasc #använd hexasc
 	nop
 	sb $v0, 4($s0) 	 #flytta svaret från hexasc till s0 	
 	POP $ra #ta tillbaks den "rena" ra
 #ta nästa 4 bitarna av sekunderna till plats 1
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
 	#Flytta ditt totala resultat till v0 som kör, hoppa tillbaks till return adress.
 	
 	move $v0, $s0	
 	jr $ra
 	nop
 		
  #
  
  delay: 
  	li $a1, 1000 #loopargumentet för whileloopen
  	move $t1, $a1  	
  	li $t2, 5000  #loopargumentet för forloopen
  	li $t3, 0
  		
 while:
 	ble $t1, 0, exit
 	addi $t1, $t1, -1 
 	
 	
  for :
  	addi $t3, $t3, 1 #lägg till 1 i ditt whileloopsargument
  	
  	bne $t3, $t2, for
  	nop
  	li $t3, 0  
  	j while	
  	
  	nop
 exit: 	
  	jr $ra 
  	nop
  	
  #
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
