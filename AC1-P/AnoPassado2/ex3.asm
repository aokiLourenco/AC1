# typedef struct
# { 			Alignment Size Offset
# char smp[10]; 		1   10      0
# double av; 			8    8     10 -> 16
# int ns; 			4    4     24
# char id; 			1    1     28 
# int sum; 			4    4     29 -> 32
# } t_cell; 			8    36->40

	.data
	
	.eqv	smp, 0
	.eqv	av, 16
	.eqv	ns, 24
	.eqv	id, 28
	.eqv	sum, 32
	
x0:	.double	0.0
x1:	.double 3.597
	
	.text
	.globl prcells
	
# Mapa
# tc: $t1 -> $a0
# size: $t2 -> $a1
# res: $f2
# aux: $f4
# i: $t0
	
prcells: move	$t1, $a0
	move	$t2, $a1
	
	la	$t3, x0
	l.d	$f2, 0($t3)
	
	li	$t0, 0
	
for:	bge	$t0, $t2, endfor
	mul	$t0, $t0, 40
	add	$t1, $t1, $t0
	
	lw	$t3, ns($t1)
	mtc1	$t3, $f6
	cvt.d.w	$f6, $f6
	
	la	$t3, x1
	l.d	$f8, 0($t3) 
	div.d	$f4, $f6, $f8
	
	add.d	$f2, $f2, $f4
	 
	s.d	$f4, av($t1)
	cvt.w.d	$f8, $f2
	
	mfc1	$t3, $f8
	sw	$t3, sum($t1)
	
	addi	$t0, $t0, 1
	j	for
endfor: mov.d	$f0, $f2
	
	jr	$ra
	