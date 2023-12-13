	.data
	.eqv SIZE, 10
	.eqv print_string, 4
	.eqv print_double, 3
	.eqv read_double, 7
arr:	.space	80
str1:	.asciiz "\nIntroduza um número: "
str2:	.asciiz "\nValor maximo: "
	.text
	.globl main
	
# Mapa de Registos
# $t0 - i
# $t1 - &arr
	
main:					# int main(void) {
	addiu	$sp, $sp, -4		# 	poem espaco na pilha
	sw	$ra, 0($sp)		#	guarda o $ra
	li	$t0, 0			#	i = 0;
	la	$t1, arr		#	$t1 = &arr;
					#
for:	bge	$t0, SIZE, endfor	#	for(i = 0; i < SIZE; i++) {
	la	$a0, str1		#		$a0 = str1;
	li	$v0, print_string	#		$v0 = 4;
	syscall				#		print_string(str1);
	li	$v0, read_double	#		$v0 = 7;		
	syscall				#		read_double();
	sll	$t3, $t0, 3		#		n = i*8
	addu	$t2, $t1, $t3		#		$t2 = &(arr[n])
	s.d	$f0, 0($t2)		#		arr[n] = read_double();
	addi	$t0, $t0, 1		#		i++;
	j	for			#	}
endfor:					#	
	move	$a0, $t1		#	arg1 = &arr;
	li	$a1, SIZE		#	arg2 = SIZE;
	jal	max			#	max(arr, SIZE);
	la	$a0, str2		#	$a0 = str2;
	li	$v0, print_string	#	$v0 = 4;
	syscall				#	print_string(str2);
	mov.d	$f12, $f0		#	$f12 = return(max);
	li	$v0, print_double	#	$v0 = 3;
	syscall				#	print_double(return(max));
					#
	lw	$ra, 0($sp)		#	repoem o valor de $ra
	addiu	$sp, $sp, 4		#	repoem o tamnhao da pilha
	li	$v0, 0			#	return 0;
	jr	$ra			# } fim do programa
	
#---------------------------------------------------------------

max:					# double max(double *p, unsigned int n) {
	move	$t0, $a0		#	$t0 = &(p)
	move	$t1, $a1		#	$t1 = n
	addi	$t1, $t1, -1		#	n = n -1;
	sll	$t1, $t1, 3		#	n = (n-1)*8;
	addu	$t2, $t0, $t1		#	u = &(p[n-1]);
	l.d	$f0, 0($t0)		#	max = *p;
	addiu	$t0, $t0, 8		#	p++;
for5:	bgt	$t0, $t2, endfor5	#	for(; p <= u; p++) {
	l.d	$f2, 0($t0)		#		$f2 = *p;
if5:	c.le.d	$f2, $f0		#		*p <= max
	bc1t	endif5			#		if(*p > max) {
	mov.d	$f0, $f2		#			max = *p;
endif5:					#		}
	addiu	$t0, $t0, 8		#		p++;
	j	for5			#	}
endfor5:				#
	jr	$ra			# } fim do programa
