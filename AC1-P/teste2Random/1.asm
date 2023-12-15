        .data

# lables
fla:    .space 20

# eqvs
        .eqv SIZE, 20
        .eqv print_float,2
        .eqv print_string,4

        .text
        .globl main

# Mapa de resgistos
# argc  : $s0
# argv  : $s1
# i     : $s2
# p     : $t0
# fla   : $s3
print:
        addi    $sp,$sp,-20
        sw      $s3,16($sp)     # guarda fla no stack
        sw      $s2,12($sp)     # guarda i no stack
        sw      $s1,8($sp)      # guarda argv no stack
        sw      $s0,4($sp)      # guarda argc no stack
        sw      $ra,0($sp)

        move    $s0,$a0         # argc
        move    $s1,$a1         # argv
        
        la	$s3,fla         # $s3 = fla

        move    $t0,$s3         # p = fla

print_if:
        ble     $s0,1,print_else	
        bgt     $s0,SIZE,print_else

        li      $s2,0           # i = 0
print_for:
        bge     $s2,$s0,print_end_for

        sll     $t1,$s2,2       # t1 = i * 4
        add     $t1,$s1,$t1     # t1 = argv[i]

        move    $a0,$t1         # a0 = argv[i]
        li      $a1,10          # a1 = 10
        jal     tof             # tof(argv[i],10)

        sw      $v0,0($t0)      # *p = tof(argv[i],10)

        j       print_for
print_end_for:

        lw      

        j       print_end_if
print_else:

print_end_if:    


        lw      $s3,16($sp)     # recupera fla do stack
        lw      $s2,12($sp)     # recupera i do stack
        lw      $s1,8($sp)      # recupera argv do stack
        lw      $s0,4($sp)      
        lw      $ra,0($sp)
        addi    $sp,$sp,20
        jr	$ra

tof:
aver: