   .data

str1: .asciiz "Result is: "
val: .word 8, 4, 15, -1987, 327, -9, 27, 16

   .eqv SIZE, 8   
   .eqv print_string, 4
   .eqv print_int10, 1
   .eqv print_char, 11

   .text
   .globl main

# Mapa de registos
# i:    $t0     
# v:    $t1    
# &(val[0]): $t2

main: li   $t0, 0

do: la	$t2, val
      sll   $t3, $t0, 2    # $t3 = i * 4
      addu  $t3, $t2, $t3  # $t3 = val + i
      lw   $t1, 0($t3)       # v = val[i]
         
    lw   $t6, 16($t3)     # $t6 = val[i + SIZE/2] = val[i+4]
    
    sw	$t6, 0($t3)      # val[i] = val[i+SIZE/12]
    sw  $t1, 16($t3)      # va[i+SIZE/2] = v
    
while: addi   $t0, $t0, 1  # i++
       bge   $t0, 4, endw
       
       j   do

endw: la   $a0, str1
      li   $v0, print_string
      syscall
 
      li   $t0, 0

do2:
     sll   $t3, $t0, 2      # i * 4
     addu   $t3, $t2, $t3
     lw   $a0, 0($t3)
    
    # move   $a0, $t2
     li   $v0, print_int10
     syscall

     li   $a0, ','
     li   $v0, print_char
     syscall

while2: addi   $t0, $t0, 1
	bge   $t0, SIZE, endw2
        j   do2

endw2: jr   $ra             
