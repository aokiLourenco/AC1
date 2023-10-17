	.data
	
lista:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
str1:	.asciiz	"\nConteudo do array:\n"
str2:	.asciiz "; "
	
	.eqv	SIZE, 10
	.eqv	print_int10, 1
	.eqv	print_string, 4
	
	.text
	.globl main
	
# Mapa
# p:	      $t0
# *p:         $t1
# lista+Size: $t2

main:	la	$a0, str1
	li	$v0, print_string
	syscall
	
	la	$t0, lista

	li	$t2, SIZE
	sll	$t2, $t2, 2
	addu	$t2, $t0, $t2

for:	bge	$t0, $t2, endfor
	
	lw	$t1, 0($t0)
	
	move	$a0, $t1
	li	$v0, print_int10
	syscall
	
	la	$a0, str2
	li	$v0, print_string
	syscall
	
	addiu	$t0, $t0, 4
	
	j	for
	
endfor:	jr 	$ra	