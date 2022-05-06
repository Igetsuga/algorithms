#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

// ---------------------------------------------------------------

int64_t gcd(int64_t a, int64_t b)
{
    while (a && b) {
        if (a > b) { a = a % b; }
        else { b = b % a; }
    }
    return (a + b);
}

// ---------------------------------------------------------------

int64_t lcm(int64_t x, int64_t y) // least common multiple
{
    return ( (x * y) / gcd(x, y) );
}

// ---------------------------------------------------------------

int64_t lcm_ex(vector<int64_t>& v) 
{

    while (v.size() > 1) {
        v[0] = ( (v[0] * v[1]) / gcd(v[0],v[1]) );
        v.erase(v.begin() + 1);
        //v.resize( v.size() );
    }

    return v[0];
}

// ---------------------------------------------------------------

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    cout << lcm(216, 426) << '\n';
    
    vector<int64_t> d{216, 426, 722, 14637};
    cout << lcm_ex(d);

    return 0;
}

