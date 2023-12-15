	.data
	
	.eqv	SIZE, 20
	.eqv	print_string, 4
	.eqv	print_float, 2
	
	.text
	.globl print
	
# Mapa
# argc: $t1 -> $a0
# argv: $t2 -> $a1
# i: $t0
# p: $f2
	
print:	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)	# argv
	sw	$s1, 8($sp)   	# argc
	
	move	$t1, $a0
	move	$t2, $a1
	
	la	$t3, SIZE
	sll	$t3, $t3, 2
	
	l.s	$f2, 0($t3)
	
if:	bge	$t1, 1, else
	blt	$t1, SIZE, else
	
	li	$t0, 0
	
for:	bge	$t0, $t1, endfor
	
	sll	$t7, $t0, 2
	addu	$t7, $s0, $t7
	
	move 	$a0, $t7
	li	$a1, 10
	jal	tof
	
	l.s	$f2, 0($v0)
	
endfor:	addi	$t0, $t0, 1
	
	mov.s	$f12, $t3
	move	$f14, $t1
	
	