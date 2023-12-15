        .data
# labels
sum:    .double 0.0
cosnt:  .double 0.035

#   
        .text
        .globl main

# Mapa de rresgitos
# val   : $f0
# array : $t0
# fx    : $t1
# k     : $t2
# sum   : $f2
# aux   : $f4
main:
        # val already in $f0
        move   $t0, $a1      # array
        li     $t1, 1        # fx = 1
        li     $t2, 0        # k = 0
        la     $t3, sum      
        l.d    $f2, 0($t3)   # sum = 0.0

calc_do:

        addi    $t3, $t2, 1     # k + 1
        mul     $t1, $t3, $t1   # fx = fx * (k + 1)

        sll     $t4, $t2, 3     # k * 8
        add     $t4, $t0, $t4   # &array[k]
        l.d     $f6, 0($t4)     # $f6 = array[k]
        mtc1    $t1, $f8        # $f8 = fx
        cvt.d.w $f8, $f8        # $f8 = (double) fx
        div.d   $f4, $f6, $f8   # aux = array[k] / fx

        add.d   $f2, $f2, $f4   # sum = sum + aux

        addi    $t2, $t2, 1     # k++
        sll     $t4, $t2, 3     # k * 8
        add     $t4, $t0, $t4   # &array[k++]
        s.d     $f2, 0($t4)     # array[k++] = sum

        la      $t3, cosnt
        l.d     $f10, 0($t3)     # aux = cosnt
        c.lt.d  $f4, $f10         # while (aux < sum)
        bc1f   calc_do       #
calc_while:     

        mfc1    $v0, $f2        # return sum

        jr      $ra
