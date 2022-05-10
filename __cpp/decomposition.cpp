#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

vector<pair<int64_t, int> > prime_vector(0, pair<int64_t,int> (0,0));

bool prime(int64_t n)
{
    int64_t itt = sqrt(n) + 1;
    for (int64_t i = 2; i < itt; i++)
    {
        if (!(n % i)) return false;
    }
    return true;
}

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

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    decomposition(1977326743);
    for (auto element : prime_vector) {
        cout << element.first << " : " << element.second << '\n';
    }

//    cout << prime(579473093) << '\n';
//    cout << prime(1977326743) << '\n';
//    cout << prime(1979339339) << '\n';

    return 0;
}

