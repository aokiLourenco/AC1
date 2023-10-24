	.data
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.align	2
array:	.word	str1, str2, str3
	.eqv	SIZE, 3
	.eqv	print_string, 4
	.eqv	print_char, 11
	
	.text
	.globl main
	
main:	li	$t0, 0
	la	$t2, array

for:	bge	$t0, SIZE, endfor
	
	sll	$t1, $t0, 2		# $t1 = i*4
	addu	$t3, $t2, $t1		# $t3 = $(array[i])
	lw	$t3, 0($t3)		# $t3 = array[i]
	
	move	$a0, $t3
	li	$v0, print_string
	syscall
	
	li	$a0, '\n'
	li	$v0, print_char
	syscall
	
	addi 	$t0, $t0, 1
	
	j	for
	
endfor:	jr	$ra
	