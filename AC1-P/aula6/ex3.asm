	.data
	
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz	"ponteiros"
	.align 2
	
str4:	.asciiz	"\nString #"
str5:	.asciiz	": "

array:	.word	str1, str2, str3

	.eqv	SIZE, 3
	.eqv	print_string, 4
	.eqv	print_char, 11
	.eqv	print_int10, 1
	
	.text
	.globl main
	
main:	li	$t0, 0
	la	$t6, array

for:	bge	$t0, SIZE, endfor
	
	la	$a0, str4
	li	$v0, print_string
	syscall
	
	move	$a0, $t0
	li	$v0, print_int10
	syscall
	
	la	$a0, str5
	li	$v0, print_string
	syscall	
	
	li	$t1, 0				# j = 0

while:	sll	$t4, $t0, 2			# $t4 = i * 4
	addu	$t3, $t6, $t4			# $t3 = array + i
	lw	$t3, 0($t3)			# $t3 = array[i]
	addu	$t3, $t3, $t1			# $t3 = array[i] + j
	lb	$t3, 0($t3)			# $t3 = array[i][j]

	beq	$t3, '\0', endw
	
	move	$a0, $t3
	li	$v0, print_char
	syscall
	
	li	$a0, '-'
	li	$v0, print_char
	syscall
	
	addi	$t1, $t1, 1
	
	j	while
	 	
endw: 	addi	$t0, $t0, 1
	j	for

endfor:	jr	$ra	