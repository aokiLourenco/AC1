		# Mapa de registos:
	#  value: $t0
	#  bit: $t1
	#  i:	$t2

	.data

str1:	.asciiz "Introduza um número: "
str2:	.asciiz "\nO valor em binário é: "

	.eqv	print_char, 11
	.eqv	print_string, 4
	.eqv	read_int, 5

	.text
	.globl main

main:	la	$a0, str1		
	li	$v0, print_string
	syscall					# print_string ("Introduza um número: ")

	li	$v0, read_int			# read_int()
	syscall
	move	$t0, $v0			# value = read_int()

	la	$a0, str2
	li	$v0, print_string
	syscall					# print_string ("\n= valor em binário é: ")

	li	$t2, 0				# i = 0
	li	$t5, 0				# flag = 0

for:	bge	$t2, 32, enfor			# while (i < 32) {
	li	$t3, 0x80000000			#    $t3 = 0x80000000
	and	$t1, $t0, $t3			#    bit = value & 0x80000000
	srl	$t1, $t1, 31
	rem	$t4, $t2, 4

if:	beq	$t5, 1, if3			# if (flag == 1)

if2:	beq	$t1, 0, endif			# if (bit != 0)

if3:	li	$t5, 1
	bne	$t4, $0, endif3			# if((i % 4) == 0)	
	li	$a0, ' '
	li	$v0, print_char
	syscall
	
	j	endif3

endif3:	addi	$a0, $t1, 0x30
	li	$v0, print_char
	syscall

endif:	sll	$t0, $t0, 1			#     value = value << 1
	addi	$t2, $t2, 1			#     i++

	j	for				# }

enfor:	jr	$ra