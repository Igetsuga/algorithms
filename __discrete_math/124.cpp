#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int x,y;
    int tunnels/* M */, crossroads/* N */; cin >> crossroads >> tunnels;
    vector<int> degrees(crossroads, 0);
    for (int i = 0; i < tunnels; i++)
    {
        cin >> x >> y;
        degrees[x - 1] += 1;
        degrees[y - 1] += 1;
    }
 
    for (int i = 0; i < crossroads; i++)
    {
        cout << degrees[i] << " ";
    }
    cout << '\n';
    degrees.clear();
 
    return 0;
}