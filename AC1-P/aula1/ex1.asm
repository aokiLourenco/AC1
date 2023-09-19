	.data
	
	.text
	.globl main
	
	# y = 2x + 8
main: 	ori $t0, $0, 3		# x = 3 = $t0
	ori $t2, $0, 8
	
	add $t1, $t0, $t0
	add $t1, $t1, $t2	# $t1 = 14
	
	jr $ra
