#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
 
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int horses; cin >> horses;
    int horse_pick; cin >> horse_pick;
 
    vector<bool> losers(horses + 1, 0);
 
    while(true) {
        int horse_win, horse_lose; cin >> horse_win;
        if (horse_win == 0) break;
        cin >> horse_lose;
        losers[horse_lose] = 1;
    }
 
    for (int itt = 1; itt < horses + 1; itt++) {
        if (itt != horse_pick && !losers[itt]) { // если любая лошадь кроме нашей кому-то не проиграла,
                                                 // либо неполные данные, либо она не проиграла нашей
            cout << "No" << '\n';
            return 0;
        }
    }
 
    cout << "Yes" << '\n';
    return 0;
}