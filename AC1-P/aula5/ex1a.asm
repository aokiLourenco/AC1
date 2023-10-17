	.data
	
	.eqv	SIZE, 5
	.eqv	read_int, 5
	.eqv	print_string, 4

str1:	.asciiz	"\nIntroduza um numero: "
	.align	2
lista:	.space	20

	.text
	.globl main
	
# i:	     $t0
# lista:     $t1
# lista + i: $t2
	
main:	li	$t0, 0				# void main(){ int i = 0; }

for:	bge	$t0, SIZE, endfor		# if (i > SIZE)
						# 	break;
	
	la	$a0, str1			
	li	$v0, print_string
	syscall					# printf("\nIntroduza um numero: ")
	
	li	$v0, read_int
	syscall
	
	la	$t1, lista			# $t1 = lista
	sll	$t2, $t0, 2			# $t2 = i * 4
	addu	$t2, $t1, $t2			# $t2 = lista[i]
	
	sw	$v0, 0($t2)			
	addi	$t0, $t0, 1			# i++
	
	j	for
		
endfor:	jr	$ra
