	.data

	.text
	.globl main

main:	li $t0,2

	srl $t3, $t0, 1
	xor $t1, $t0, $t3  

	jr $ra