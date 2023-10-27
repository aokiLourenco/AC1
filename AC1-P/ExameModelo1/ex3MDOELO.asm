	.data
	
a:	.space 35
	.align 2
b2:	.space 35

	.eqv	N, 35	
	.eqv	read_int, 5
	.eqv	print_int10, 1
	
	.text
	.globl main
	
# Mapa de registos:
# n_even:	$t0
# n_odd:	$t1
# p1:	$t2
# p2:	$t3

main:	li	$t0, 0
	li	$t1, 0
	
	la	$t4, a
	la	$t5, b2
	
	lw	$t2, 0($t4)
	addi	$t6, $t2, N
	
for:	bge	$t2, $t6, for2
	
	li	$v0, read_int
	syscall
	sw	$v0, 0($t2)
	
	addi	$t2, $t2, 4
	j	for

for2:	lw	$t2, 0($t4)
	lw	$t3, 0($t5)
	addi	$t6, $t2, N
	
	bge	$t2, $t6, for3
	
	rem	$t7, $t2, 2
if:	beq	$t7, $0, else
	
	sw	$t2, 4($t3)
	
	addi	$t1, $t1, 1

else:	addi	$t1, $t1, 1

	addi	$t2, $t2, 4	
	j	for2

for3:	lw	$t3, 0($t5)
	add	$t5, $t5, $t1
	
	bge	$t3, $t5, endf3
	
	lw	$a0, 0($t3)
	li	$v0, print_int10
	syscall
	
	addi	$t3, $t3, 4
	
	j	for3

endf3:	jr	$ra