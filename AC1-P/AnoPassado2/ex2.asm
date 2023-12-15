	.data
	
x0:	.double 0.0

	.text
	.globl proc

# Mapa
# array: $t1 -> a0
# thd:	$f2 -> f12
# val:	$f4 -> f14
# n:	$t2 -> a1
# i:	$t0
# aux: $f6
# sum: $f8

proc:	la	$t0, x0
	l.d	$f8, 0($t0)
	
	mov.d 	$f2, $f12
	mov.d	$f4, $f14
	move	$t1, $a0
	move	$t2, $a1
	
	li	$t0, 0
	
for:	bge	$t0, $t2, endfor
	
	sll	$t7, $t0, 2
	addu	$t7, $t1, $t7
	
	l.d	$f6, 0($t7)
	add.d	$f6, $f6, $f4
	
if:	c.le.d 	$f6, $f2
	bc1t	else
	
	s.d	$f4, 0($t7)
	add.d	$f8, $f8, $f4
	
	j	endif
	
else:	s.d	$f6, 0($t7)
	add.d	$f8, $f8, $f6
	
endif:	addi	$t0, $t0, 1
	j	for
	
endfor:	mtc1	$t2, $f10
	cvt.d.w	$f10, $f10
	
	div.d	$f0, $f8, $f10
	
	jr	$ra
