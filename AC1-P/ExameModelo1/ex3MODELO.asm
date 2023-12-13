   .data
   
   .eqv N, 35
   
lista:	.space	35
	.align 2
lista2:	.space	35

   .eqv print_int10, 1
   .eqv read_int, 5
   
   .text
   .globl main

# Mapa de registos
# n_even: $t0
# n_odd:  $t1
# p1:     $t2
# p2:     $t3

main: li   $t0, 0
      li   $t1, 0
      la   $t2, lista
      addi $t4, $t2, N
      
for: bge $t2, $t4, for2
     lw   $t5, 0($t2)
     li   $v0, read_int
     syscall
     move   $t5, $v0
     addiu  $t2, $t2, 4
     j for
    
     la   $t2, lista
     la   $t3, lista2
     
for2: bge   $t2, $t4, for3
      rem   $t5, $t5, 2
if:   beq   $t5, 0, else
     lw   $t6, 0($t3)
     addiu $t6, $t6, 1
     move   $t6, $t5
     addi   $t1, $t1, 1

else: addi   $t0, $t0, 1

      addiu  $t2, $t2, 4
      j   for2

      la   $t3, lista2
      addu $t7, $t3, $t1 
      
      j	for2

for3: bge   $t2, $t7, endf3
      move   $a0, $t6
      li   $v0, print_int10
      syscall

      addiu  $t2, $t2, 4
      j   for3

endf3: jr   $ra
       