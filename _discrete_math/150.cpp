#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
vector<vector<int>> adj(0, vector<int>(0,0)); // в i-ой ячейке хранятся все инцидентные с i вершины
int FRIENDS = 0;
 
void dfs(int edge, vector<bool>& used)
{
    used[edge] = true;
     
    for (auto nb : adj[edge])
    {
        if ( !used[nb] ) { FRIENDS++; dfs(nb, used); }
    }
}
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int N; cin >> N;
    int person; cin >> person;
    adj.resize(N);
 
    for (int itt = 0; itt < N; itt++)
    {
        for (int j = 0; j < N; j++)
        {
            bool friendly = 0; cin >> friendly;
            if (friendly) { adj[itt].push_back(j); }
        }
    }
 
 
    vector<bool> used(N,0);
    // used[person - 1] = true;
    for (int itt = 0; itt < adj[person - 1].size(); itt++)
    {
        dfs(adj[person - 1][itt], used);
    }
 
    cout << FRIENDS << '\n';
 
//    int sum = -1;
//    for (int itt = 0; itt < N; itt++)
//    {
//        sum += used[itt];
//    }
//
//    cout << (N - sum) + 1;
 
 
//    for (int itt = 0; itt < N; itt++)
//    {
//        cout << itt << " >> ";
//        for (auto element : adj[itt])
//        {
//            cout << " : " << element;
//        }
//        cout << '\n';
//    }
 
 
 
 
 
 
    return 0;
}