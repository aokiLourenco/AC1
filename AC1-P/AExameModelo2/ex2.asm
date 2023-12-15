    .data

x0: .float  -1.0
x1: .float 1.0
x2: .float 0.0

    .text
    .globl func3

# Mapa de registos
# a: $t0 -> $a0
# t: $f2 -> $f12
# n: $t4 -> $a1
# oldg: $f6
# g: $f8
# s: $f10
# k: $t1

func3:  move    $t0, $a0
        move    $f2, $f12
        move    $t4, $a1

        li      $t2, x0
        li      $t3, x1
        li      $t4, x2

        l.s     $f6, 0($t2)
        l.s     $f8, 0($t3)
        l.s     $f10, 0($t4)

        li      $t1, 0

for:    bge     $t1, $f4, endfor

        sub.s   $f12, $f8, $f6

while:  ble     $f12, $f2, endw

        mov.s   $f6, $f8                # oldg = g

        sll     $t5, $t1, 2             # k * 4
        addiu   $t5, $t0, $t5           # a + k

        l.s     $f0, 0($t5)

        add.s   $f14, $f0, $f8

        div.s   $f8, $f14, $f8

        j       while

endw:   add.s   $f10, $f10, $f8

        s.s     $f8, 0($f0)

endfor: mtc1    $f4, $f4