		# Mapa de registos:
	#  value: $t0
	#  bit: $t1
	#  i:	$t2

	.data

str1:	.asciiz "Introduza um n�mero: "
str2:	.asciiz "\nO valor em bin�rio �: "

	.eqv	print_char, 11
	.eqv	print_string, 4
	.eqv	read_int, 5

	.text
	.globl main

main:	la	$a0, str1		
	li	$v0, print_string
	syscall					# print_string ("Introduza um n�mero: ")

	li	$v0, read_int			# read_int()
	syscall
	move	$t0, $v0			# value = read_int()

	la	$a0, str2
	li	$v0, print_string
	syscall					# print_string ("\n= valor em bin�rio �: ")

	li	$t2, 0				# i = 0

for:	bge	$t2, 32, enfor			# while (i < 32) {
	li	$t3, 0x80000000			#    $t3 = 0x80000000
	and	$t1, $t0, $t3			#    bit = value & 0x80000000
	srl	$t1, $t1, 31
	
	rem	$t4, $t2, 4

if:	bne	$t4, $0, endif
	li	$a0, ' '
	li	$v0, print_char
	syscall
	
	j	endif

endif:	addi	$a0, $t1, 0x30
	li	$v0, print_char
	syscall

	sll	$t0, $t0, 1			#     value = value << 1
	addi	$t2, $t2, 1			#     i++

	j	for				# }

enfor:	jr	$ra