	.data

str1:	.asciiz "Introduza 2 numeros\n"
str2:	.asciiz "A soma dos dois numeros e': "
	
	.eqv printString, 4
	.eqv readInt, 5
	.eqv printInt10, 1

	.text
	.globl main

main:	la $a0, str1
	li $v0, printString
	syscall

	li $v0, readInt
	syscall
	or $t0, $v0, $0

	li $v0, readInt
	syscall
	or $t1, $v0, $0

	add $t1, $t0, $t1
	
	la $a0, str2
	li $v0, printString
	syscall

	or $a0, $0, $t1
	li $v0, printInt10
	syscall

	jr $ra

	 	