#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

int64_t bin_pow(int64_t x, int64_t pow, int64_t module)
{
    int64_t result = 1;
    while (pow > 0) {
        if (pow & 0x01) {
            result = (result * x) % module; // pow = pow - 1;
        }
        x = (x * x) % module; // x ** 2 ==> pow = pow / 2;
        pow >>= 1;
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

// ---------------------------------------------------------------

int cnk(int n, int k, int64_t mod)
{
    int64_t numerator = 1;
    int64_t denominator = 1;

    if (k > n / 2) { k = (n - k); }

    for (int itt = 0; itt < k; itt++ ) {
        numerator = ( numerator * (n - itt) ) % mod;
        denominator = ( denominator * (itt + 1) ) % mod;
    }

    return ( numerator * inverse_element(denominator, mod) % mod );
}

// ---------------------------------------------------------------

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    cout << cnk(10, 4, 1000*1000*1000+7) << '\n';
    cout << cnk(250, 79, 1000*1000*1000+7) << '\n';
    cout << cnk(75943, 427, 1000*1000*1000+7) << '\n';
    cout << cnk(985933, 46839, 1000*1000*1000+7) << '\n';

    return 0;
}

