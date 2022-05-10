#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
    int cases; cin >> cases;
    bool currentValue = 0;
    int bridges_bad = 0;
    vector<vector<int>> hills(cases, vector<int>(cases, 0));
    for (int i = 0; i < cases; i++)
    {
        for (int j = 0; j < cases; j++)
        {
            cin >> currentValue;
            hills[i][j] = currentValue;
        }
    }
 
    map<int, int> colors;
    for (int hill = 0; hill < cases; hill++)
    {
        int color = 0; cin >> color;
        colors.insert(pair<int,int> (hill, color));
    }
 
    for (int i = 0; i < cases - 1; i++)
    {
        for (int j = i; j < cases; j++)
        {
            if ( (hills[i][j] == 1) & (colors[i] != colors[j]) ) bridges_bad++;
        }
    }
 
    cout << bridges_bad << '\n';
 
 
    return 0;
}