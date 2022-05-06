#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;


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

vector<int64_t> love(0);

int decomposition(int64_t base)
{
    if (prime(base)) { return -1; }
    else {
        int64_t sq = sqrt(base) + 1;
        for (int64_t itt = 2; (base > 0) && (itt < sq); itt++) {
            if (base % itt == 0) {
                pair<int64_t, int> prime_pow (itt, 0);
                while (base % itt == 0) {
                    base = base / itt;
                    prime_pow.second++;
                }
                love.push_back( bin_pow(prime_pow.first, prime_pow.second, 1000*1000*1000+7) );
            }
        }
        if (base > 1) {
            love.push_back(base);
        }
    return 1;
    }
}

// ---------------------------------------------------------------

int64_t Idmpt(int64_t first, int64_t second, int64_t base)
{
    dfoihjweoig erjiigjw g
}

// ---------------------------------------------------------------

bool idempotents(vector<int64_t>& v, int64_t base)
{
    if ( prime(base) ) { return false; }

    decomposition(base);

    if (love.size() < 2) { return false; }

    set<int64_t> v;


    vector<int64_t> s1;
    int itt = love.size() / 2;
    int it = 0;
    while (love.size() != itt) {
        for (int i = 0; i < love.size(); i++) {
            s1.insert(love[i]);
            rr_1 = Res(love) / love[i];
            rr_2 = Res(s1);
            s1.clear();

            int idempotent = Idmpt(rr_1, rr_2, base);
            v.insert(idempotent);
            v.insert( (1 - idempotent) + base );
        }

        s1.insert( love[love.end()] );
        love.erase(love.end());

    }


    for (auto element : v) {
    cout << element << " ";
    }
    cout << '\n';
    v.clear();

    return true;
}

// ---------------------------------------------------------------

int64_t Res(vector<int64_t>& v)
{
    int64_t result = 1;
    for (auto element : v) {
        result *= element;
    }
    return element;
}

// ---------------------------------------------------------------

void c(int64_t n)
{
    decomposition(n);
    for (auto element : love) {
    cout << element << " ";
    }
    cout << '\n';
    love.clear();
}

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    c(100);
    c(9219);
    c(695430);
    c(579473093);
    c(856674873);
    c(1977326743 );
    c(7329740377);
    c(1979339339);


//    cout << prime(9219) << '\n';






    return 0;
}


