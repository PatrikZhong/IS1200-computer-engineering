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
  #
  # Please add your own code below this line
  .globl time2string
  .globl delay
  .globl enable_interrupt
  
  .data
  .align 2
  
  .text
 hexasc: 
  move $t1, $a0
  
  andi $t1, $t1, 15
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
  
  # hexasc end
  
  .data
  .align 2
  .text
  delay:
  li $t1, 1000     # ms värdet för while-loopen
  li $t2, 0      # i-värdet för for-loopen
  li $t3, 139   # värdet för for-loopen, constant
  while:
  
  addi $t1, $t1, -1
  li $t2, 0
  for:
  addi $t2, $t2, 1
  
  bne $t2, $t3, for 
  nop   # hoppa till början av for-loop
  bne $t1, $0, while   # hoppa till början av while loop
  nop
  
  jr $ra
  nop
  
  # delay end

  .data
  .align 2
  .text
time2string:
# vi sätter en-tals sekundrarna till byte plats 0 i $s0 ;)
PUSH $s0
move $s0, $a0
andi $t0, $a1, 0xf
move $a0, $t0
PUSH $ra
jal hexasc
nop
sb $v0, 4($s0)
POP $ra

# vi sätter tio-tals sekundrarna till byte plats 1 i $s0 ;)
srl $a1, $a1, 4
andi $t0, $a1, 0xf
move $a0, $t0
PUSH $ra
jal hexasc
nop
sb $v0, 3($s0)
POP $ra

# vi sätter tio-tals sekundrarna till byte plats 3 i $s0 ;)
srl $a1, $a1, 4
andi $t0, $a1, 0xf
move $a0, $t0
PUSH $ra
jal hexasc
nop
sb $v0, 1($s0)
POP $ra

# vi sätter tio-tals sekundrarna till byte plats 4 i $s0 ;)
srl $a1, $a1, 4
andi $t0, $a1, 0xf
move $a0, $t0
PUSH $ra
jal hexasc
nop
sb $v0, 0($s0)
POP $ra

# vi sätter in : till byte-plats 2 i $s0 ;)
li $t0, 58
sb $t0, 2($s0)
# sb $t0, 2($s0)
# vi sätter in null till byte-plats 5 i $s0 ;)
li $t0, 0
sb $t0, 5($s0)
#
move $v0, $s0

POP $s0
jr $ra
nop
#slutet av time2string

enable_interrupt: 

	ei
	jr $ra
	nop

