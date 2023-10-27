   .data

str1: .asciiz "Digite ate 20 inteiros (zero para terminar):"
str2: .asciiz "Máximo/mínimo são: "
   
   .eqv print_string, 4
   .eqv print_int10, 1
   .eqv print_char, 11
   .eqv read_int, 5

   .text
   .globl main

# Mapa de registos
# val: $t0
# n:   $t1
# min: $t2
# max: $t3

main: li   $t1, 0

      li   $t2, 0x7FFFFFFF
      li   $t3, 0x80000000

      la   $a0, str1
      li   $v0, print_string
      syscall

do:    li   $v0, read_int
       syscall
       move   $t0, $v0
       
if:    beq   $t0, 0, endif    

if2:   ble   $t0, $t3, if3
       addi   $t3, $t0, 0

if3:   bge   $t0, $t2, endif
       addi   $t2, $t0, 0

endif: addi   $t1, $t1, 1

while: bge   $t1, 5, endw
       beq   $t0, 0, endw
       
       j   do

endw:  la   $a0, str2
       li   $v0, print_string
       syscall

       move   $a0, $t3
       li   $v0, print_int10
       syscall

       li   $a0, ':'
       li   $v0, print_char
       syscall

       move   $a0, $t2
       li   $v0, print_int10
       syscall

       jr   $ra
      