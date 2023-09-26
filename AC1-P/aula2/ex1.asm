	.data


	.text
	.globl main
	
	.eqv val_1, 0x5C1B
	.eqv val_2, 0xA3E4

main:	ori $t0, $0, val_1
	ori $t1, $0, val_2

	and $t2, $t0, $t1	# $t2 = $t0 & $t1
	or $t3, $t0, $t1	# $t3 = $t0 | $t1
	nor $t4, $t0, $t1	# $t4 = ~($t0 | $t1)
	xor $t5, $0, $t1	# $t5 = ($t0^$t1)
	
	jr $ra