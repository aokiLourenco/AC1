#define SIZE 15

int toi (char *);
int avz (int *, int);

int func2(int *fl, int k, char *av[])
{
    int i;
    int res;

    if ((k >= 2) && (k <= SIZE))
    {
        i = 2;
        do {
            fl[i-2] = toi(av[i]);
            i++;
        } while (i < k);
        res = avz(fl, k);
        print_int10(res);
    } else {
        print_string("Invalid argc");
        res = -1;
    }
    return res;
}

/*
# Mapa de registos
# fl:
# k:
# av:
# i:
# res:
*/
