# typedef struct
# {                         Align       Size        Offset
#     char id;              1           1           0
#     double av;            8           8           1->8
#     int ns;               4           4           16
#     char smp[18];         1           18          20
#     int sum;              4           4           38->40
# } t_kvd;                  8           44          


        .data

# lables
sum1:    .double 0.0

# offsets
        .eqv    id, 0
        .eqv    av, 8
        .eqv    ns, 16
        .eqv    smp, 20
        .eqv    sum, 40

        .text
        .globl  main


# Mapa de resgistos
# ts    : $t0
# nval  : $t1
# sum   : $f0
# n     : $t2
# k     : $t3 
# acc   : $t4
# pu    : $t5
main:
        move    $a0, $t0        # ts
        move    $a1, $t1        # nval
        la      $t6, sum1        # 
        l.d     $f0, 0($t6)     # sum 
        li      $t4, 0          # n = 0

        add     $t5, $t0, $t1   # *pu = ts + nval

proc_for1:
        bge     $t0, $t5, proc_end_for1     # for (ts < pu)

        li      $t3, 0          # k = 0
proc_for2:
        lw      $t6, ns($t0)    # $t6 = ts->ns
        bge     $t3, $t6, proc_end_for2     # for (k < ts->ns)


        lw      $t7, smp($t0)   # $t7 = ts->smp[k]
        add     $t4, $t4, $t7   # n += ts->smp[k]


        addi    $t3, $t3, 1      # k++
        j       proc_for2
proc_end_for2:

        sw      $t4, sum($t0)   # ts->sum = acc

        mtc1    $t4, $f2        # $f2 = acc
        cvt.d.w $f2, $f2        # $f2 = (double)acc
        l.d     $f4, ns($t0)    # $f1 = ts->ns
        cvt.d.w $f4, $f4        # $f1 = (double)ts->ns
        div.d   $f6, $f2, $f4   # $f6 = (double)acc / (double)ts->ns
        s.d     $f6, av($t0)    # ts->av = (double)acc / (double)ts->ns

        l.d     $f8, av($t0)    # $f8 = ts->av
        add.d   $f0, $f0, $f8   # sum += ts->av
        
        addi    $t0, $t0, 44    # ts++
        j       proc_for1
proc_end_for1:

        cvt.s.d $f0, $f0        # $f0 = (float)sum
        mov.s   $f12, $f0       # return sum

        jr      $ra

