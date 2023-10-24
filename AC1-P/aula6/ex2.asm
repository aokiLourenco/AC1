	.data
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"

	.align 2
	
array:	.word	str1, str2, str3
	
	.eqv	SIZE, 3
	.eqv	print_char, 11
	.eqv	print_string, 4
	
	.text
	.globl main
	
# p:	$t1
# pultimo:	$t2
	
main:	la	$t1, array		# p = array;
	li	$t5, SIZE		# $t5 = SIZE;
	sll	$t5, $t5, 2		# $t5 = SIZE * 4;
	
	addu	$t2, $t1, $t5		# pultimo = p + SIZE;
	
for:	bgeu	$t1, $t2, endfor	# while (p < pultimo) {
	lw	$t3, 0($t1)		# 	$t3 = *p;
	
	move	$a0, $t3		#	$a0 = $t3;
	li	$v0, print_string
	syscall				#	print_string(*p);
		
	li	$a0, '\n'
	li	$v0, print_char
	syscall				#	print_char('\n');
	
	addiu	$t1, $t1, 4		#	p++;
	
	j	for			# }
	
endfor:	jr	$ra			
	
	