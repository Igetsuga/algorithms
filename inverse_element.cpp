#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

int64_t bin_pow(int64_t x, int64_t pow, int64_t module)
{
    int64_t result = 1;
    while (pow > 0) {
        if (pow & 0x01) { // побитовая конъюнкция <=> (pow % 2 == 1);
            result = (result * x) % module; // pow = pow - 1;
        }
        x = (x * x) % module; // x ** 2 ==> pow = pow / 2;
        pow >>= 1; // сдвигаю все биты числа вправо тем самым происходит деление числа на 2; <=> pow /= 2;
    }
    return result;
}

bool prime(int64_t n)
{
    int64_t itt = sqrt(n) + 1;
    for (int64_t i = 2; i < itt; i++)
    {
        if (!(n % i)) return false;
    }
    return true;
}

int64_t phi(int64_t value)
{
    if (!prime(value)) {
        int64_t phi = value;
        int64_t itt = sqrt(value) + 1;

        for (int64_t i = 2; (i <= itt) && (value >= i) ;i++)
        {
           if (value % i == 0)
            {
            phi -= phi/i;
            while (value % i == 0) value /= i;
            }
        }
        if (value > 1)
        {
            phi = phi - phi/value;
        }
        return phi;
    }
    else return (value - 1);
}

int64_t gcd(int64_t x, int64_t y)
{
    while (x != 0 && y != 0) {
        if ( x > y) { x = x % y; }
        else { y = y % x; }
    }
    return (x + y);
}

int64_t inverse_element(int64_t element, int64_t my_modulus)
{
    int64_t result;
    if (gcd(element, my_modulus) > 1) return -1;
    else {
        result = bin_pow(element, phi(my_modulus) - 1, my_modulus);
        while (result < 0) {
            result += my_modulus;
        }
    }
    return result;
}

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);


    // cout << bin_pow(48923063, 1847751263, 346926136) << '\n';
    cout << gcd(48923063,3469261365) << '\n';
    cout << "----------------------" << '\n';
    // cout << bin_pow(48923063, 1847751263, 3469261365) + 3469261365 << '\n';
    cout << "----------------------" << '\n';
    cout << inverse_element(5, 7) << '\n';
    cout << inverse_element(28, 851) << '\n';
    cout << inverse_element(492361, 4327698) << '\n';
    cout << inverse_element(423589, 3469362) << '\n';
    cout << inverse_element(47328632, 348623846) << '\n';
    cout << inverse_element(48923063, 3469261365) << '\n';
    cout << inverse_element(34235285, 443987593) << '\n';

    return 0;
}





