#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;


// ---------------------------------------------------------------

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

    if (value == 1) { return 1; }

    if (prime(value)) { return (value - 1); }


    int64_t phi = value;
    int64_t itt = sqrt(value) + 1;

    for (int64_t i = 2; (i <= itt) and (value >= i) ;i++)
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

// ---------------------------------------------------------------

int64_t bin_pow(int64_t x, int64_t pow, int64_t module)
{
    int64_t result = 1;
    while (pow > 0) {
        if (pow & 0x01) { //  <=> (pow % 2 == 1);
            result = (result * x) % module; // pow = pow - 1;
        }
        x = (x * x) % module; // x ** 2 ==> pow = pow / 2;
        pow >>= 1; //  <=> pow /= 2;
    }
    return result;
}

// ---------------------------------------------------------------

int order(int element, int base)
{
    set<int> dividers;
    int order_max = phi(base);

    for (int itt = 2; itt < order_max / 2; itt++) {
        if (order_max % itt == 0) {dividers.insert(itt); dividers.insert(base / itt); }
    }

//    for (auto element : dividers) {
//        cout << element << " : ";
//    }
//    cout << '\n';

    for (auto element_s : dividers) {
        if (bin_pow(element, element_s, base) == 1) {return element_s; }

    }

    return ( base - 1 );
}

// ---------------------------------------------------------------


int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);


    cout << order(18, 31) << '\n';
    cout << order(452, 2003) << '\n';
    cout << order(32068, 5076377 ) << '\n';
    cout << order(9477501, 1000000801) << '\n';
    cout << order(17009344, 1979339339) << '\n';

//    cout << bin_pow(32068, 5076376, 5076377 ) << '\n';
//    cout << bin_pow(9477501, 1000000800, 1000000801 ) << '\n';
//    cout << prime( 1000000801 ) << '\n';
//    cout << prime( 5076377 ) << '\n';
//    cout << prime( 1979339339 ) << '\n';



    return 0;
}


