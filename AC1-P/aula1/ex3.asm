	.data
	
	.text
	.globl main
	
main:	ori $v0, $0, 5	# syscall read_int()
	syscall
	or $t0, $0, $v0	# $t0 = $v0 = valor lido do teclado (valor de x pretendido)
	
	ori $t2, $0, 8	# $t2 = 8
	add $t1, $t0, $t0	# $t1 = $t0 + $t0 = x + x = 2x
	sub $t1, $t1, $t2	# $t1 = 2x - 8
	
	or $a0, $0, $t1 	# $a0 = y
	ori $v0, $0, 1	# syscall print_int10
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	or $a0, $0, $t1
	ori $v0, $0, 34
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
	or $a0, $0, $t1
	ori $v0, $0, 36
	syscall
	
	jr $ra