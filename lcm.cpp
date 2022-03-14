#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

int64_t gcd(int64_t a, int64_t b)
{
    while (a && b) {
        if (a > b) { a = a % b; }
        else { b = b % a; }
    }
    return (a + b);
}

int64_t lcm(int64_t x, int64_t y) // least common multiple
{
    return ( (x * y) / gcd(x, y) );
}


int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    int64_t x, y; cin >> x >> y;

    cout << lcm(x,y) << '\n';

    return 0;
}

