	.data
	 
	.text
	.globl primes
	
# Mapa
# array: $t0
# low: $t1
# high: $t2
# i: $s0
# npr: $t3
# p: $t4
	
primes:	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)	# i na stack
	
	move	$t0, $a0	# array
	move	$t1, $a1	# low
	move	$t2, $a2	# high
	
	move	$t4, $t0	# p = array
	
	addi	$s0, $t1, 1
	li	$t3, 0
	
for:	bge	$s0, $t2, endfor
	
if:	move	$a0, $s0
	jal	checkp
	
	bne	$v0, 1, endfor
	sw	$s0, 0($t0)		
	
	addiu	$t0, $t0, 1
	addi	$t3, $t3, 1
	
	addi	$s0, $s0, 1
	j	for	

endfor: add	$t5, $t3, $t4		# $t5 = p + npr
	sw	$t3, 0($t5)
	move	$v0, $t3
	
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)	
	addiu	$sp, $sp, 8
	
	jr	$ra
	
checkp: