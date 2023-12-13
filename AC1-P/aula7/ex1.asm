	.data
str1:	.asciiz "Arquitetura de Computadores I"
	.text
	.globl main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	la	$a0, str1
	jal	strlen
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	li	$v0, 0
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
strlen:	li	$t1, 0
	
while:	lb	$t0, 0($a0)
	addiu	$a0, $a0, 1
	beq	$t0, '\0', endw
	addi	$t1, $t1, 1
	j	while
	
endw:	move	$v0, $t1
	jr	$ra