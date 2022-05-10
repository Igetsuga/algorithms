#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

vector<pair<int64_t, int> > prime_vector(0, pair<int64_t,int> (0,0));

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

// ---------------------------------------------------------------

int64_t phi(int64_t value)
{
    if (value == 1) { return 1; }

    if (!prime(value)) {
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
    else return (value - 1);
}

// ---------------------------------------------------------------

int64_t gcd(int64_t a, int64_t b)
{
    while (a && b) {
        if (a > b) { a = a % b; }
        else { b = b % a; }
    }
    return (a + b);
}

int64_t lcm_ex(vector<int64_t>& v) // least common multiple
{

    while (v.size() > 1) {
        v[0] = ( (v[0] * v[1]) / gcd(v[0],v[1]) );
        v.erase(v.begin() + 1);
        //v.resize( v.size() );
    }

    return v[0];
}

// ---------------------------------------------------------------

int64_t bin_pow(int64_t x, int64_t pow, int64_t module)
{
    int64_t result = 1;
    while (pow > 0) {
        if (pow & 0x01) { // <=> (pow % 2 == 1);
            result = (result * x) % module; // pow = pow - 1;
        }
        x = (x * x) % module; // x ** 2 ==> pow = pow / 2;
        pow >>= 1; //  <=> pow /= 2;
    }
    return result;
}

// ---------------------------------------------------------------

int decomposition(int64_t base)
{
    if (prime(base)) { return -1; }
    else {
        int64_t sq = sqrt(base) + 1;
        for (int64_t itt = 2; itt < sq; itt++) {
            if (base % itt == 0) {
                pair<int64_t, int> prime_pow (itt, 0);
                while (base % itt == 0) {
                    base = base / itt;
                    prime_pow.second++;
                }
                prime_vector.push_back(prime_pow);
            }
        }
        if (base > 1) {
            prime_vector.push_back(pair<int64_t,int> (base, 1));
        }
    return 1;
    }
}

// ---------------------------------------------------------------

int64_t order_max(int64_t base)
{
    if ( prime(base) ) { return ( base - 1); }
    else {
        decomposition(base);

        vector<int64_t> vector_base (0);
        for (auto element : prime_vector) {
            if ( element.first == 2 ) { element.second--; }
            vector_base.push_back( phi( bin_pow(element.first, element.second, 1000*1000*1000+7) ) );
        }
        prime_vector.clear();
        return lcm_ex(vector_base);
    }
}

// ---------------------------------------------------------------

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);


    cout << order_max(61) << '\n';
    cout << order_max(800) << '\n';
    cout << order_max(55450) << '\n';
    cout << order_max(2383254) << '\n';
    cout << order_max(316030564) << '\n';
    cout << order_max(730887505) << '\n';
    cout << order_max(1847653789) << '\n';
    cout << order_max(1478783811) << '\n';


    return 0;
}

