	.data

str1:	.asciiz "Uma string qualquer\n"
str2:	.asciiz "AC1 - P"
	
	.eqv printString, 4

	.text
	.globl main

main:	la $a0, str1
 	li $v0, printString
	syscall

	la $a0, str2
	li $v0, printString
	syscall

	jr $ra