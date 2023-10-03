	# Mapa de registos:
	# soma:	$t0
	# value: $t1
	# i: $t2

	.data
str1:	.asciiz	"Introduza um n�mero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos �: "
	
	.eqv	print_string, 4
	.eqv	read_int, 5
	.eqv	print_int10, 1
	.text
	.globl main

main:	li	$t0, 0			# soma = 0
	li	$t2, 0			# i = 0
					#
for:	bge	$t2, 5, endfor		# while(i < 5) {
	la	$a0, str1		# 	print_string("Introduza um n�mero");
	li	$v0, print_string	#
	syscall				#
	li	$v0, read_int 		# 	value=read_int();
	syscall				#
	move	$t1, $v0		#	# $t1 = value
	ble	$t1, $0, else		# 	if(value > 0)
	add	$t0, $t0, $t1		#		soma += value;
	j	endif			#
					#
else:					#	else
	la	$a0, str2		#		print_string("Valor ignorado\n");
	li	$v0, print_string	#
	syscall				#
					#
endif:	addi	$t2, $t2, 1		#	i++;
	j	for			# }
					#
endfor:	la	$a0, str3		# print_string("A soma dos positivos �: ");
	li	$v0, print_string	# 
	syscall				#
	move	$a0, $t0		# print_int10(soma);
	li	$v0, print_int10
	syscall

	jr	$ra