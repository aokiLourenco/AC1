    .data
    
    .eqv    print_int10, 1
    .eqv    print_string, 4
    .eqv    SIZE, 15
str:    .asciiz "Invalid argc"

    .text
    .globl func2

# Mapa de registos
# i:    $t0
# fl:   $t1 -> $a0
# k:    $t2 -> $a1
# av:   $t3 -> a2
# res:  $t4

func2:  addiu   $sp, $sp, -16
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)             # fl
        sw      $s1, 8($sp)             # k
        sw      $s2, 12($sp)            # av
        
        move    $t1, $a0
        move    $t2, $a1
        move    $t3, $a2

if:     blt		$t2, 2, else            # k >=2
        bgt     $t2, SIZE, else         # k <= SIZE

        li      $t0, 2                  # i = 2

do:     subi    $t5, $t0, 2             # i - 2 
        sll     $t5, $t5, 2             # (i -2) * 4
        addiu   $t5, $t1, $t5           # fl + i

        sll     $t6, $t0, 2             # i * 4 
        addiu   $t6, $t3, $t6           
        lw      $a0, 0($t6)
        jal     toi                     # toi (av[i])

        sw      $v0, 0($t5)             # fl = toi

        addi    $t0, $t0, 1             # i++        

while:  bge		$t0, $t2, enddo         # i < k

        j       do
        
enddo:  move    $a0, $t1
        move    $a1, $t2
        jal     avz                     # avz (fl, k)

        move    $t4, $v0                # res = avz

        li      $a0, $t4
        li      $v0, print_int10
        syscall
        
        j       endif

else:   la      $a0, str
        li      $v0, print_string
        syscall

        li      $t4, -1

endif:  move    $v0, $t4

        lw      $s2, 12($sp)            # av
        lw      $s1, 8($sp)             # k
        lw      $s0, 4($sp)             # fl
        lw      $ra, 0($sp)
        addiu   $sp, $sp, 16

        jr      $ra