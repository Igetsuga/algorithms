#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int cases; cin >> cases;
    bool currentValue = 0;
    int edges = 0;
 
    for (int it = 1; it < cases; it++)
    {
        for (int j = 1; j <= cases; j++)
        {
            cin >> currentValue;
            if (j > it)
            {
                edges += currentValue;
            }
        }
    }
    cout << edges << '\n';
    /*for (int it = 0; it < edges.size(); it++)
    {
        cout << edges[it] << " | ";
    }
    */
    /*for (int it = 0; it < graph.size(); it++)
    {
        edges += graph[it];
    }
    cout << edges / 2;
    */
    return 0;
}