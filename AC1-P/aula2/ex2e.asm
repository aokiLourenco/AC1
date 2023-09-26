	.data

	.text
	.globl main

main:	li $t0, 7
	
	ori $t1, $t0, 0		# num = gray
	
	srl $t3, $t1, 4		# $t3 = num >> 4
	xor $t4, $t1, $t3	# $t4 = num ^ $t3 = num
	srl $t5, $t4, 2		# $t5 = num >> 2
	xor $t4, $t4,$t5	# $t4 = $t4 ^ $t5
	srl $t6, $t4, 1 	# $t6 = num >> 1
	xor $t4, $t4, $t6	# $t4 = $t4 ^ $t6
	
	ori $t2, $t4, 0		# $t2 = $t4 -> bin = num

	jr $ra