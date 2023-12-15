float func3 (float *a, float t, int n)
{
    float oldg = -1.0;
    float g = 1.0;
    float s = 0.0;
    int k;

    for (k = 0; k < n; k++) {
        while ((g - oldg) > t) {
            oldg = g;
            g = (g + a[k]) / t;
        }
        s = s + g;
        a[k] = g;
    }

    return s / (float) n;
}

/*
# Mapa de registos
# a: $t0 -> $a0
# t: $f2 -> $f12
# n: $f4 -> $f14
# oldg: $f6
# g: $f8
# s: $f10
# k: $t1
*/