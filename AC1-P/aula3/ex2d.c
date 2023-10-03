void main(void)
{
    unsigned int value, bit, i;
    int flag;
    
    print_string("Enter a value: ");
    value = read_int();
    print_string("Enter a bit number: ");

    for(i = 0, flag= 0, i < 32; i++)
    {
        bit = value >> 31;
        if (flag == 1 || bit!= 0)
        {
            flag = 1;
            if ((i % 4) == 0)
                print_char(' ');
            print_char(bit + '0');
        }
        value = value << 1;
    }

}