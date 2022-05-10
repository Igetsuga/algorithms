#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
vector<vector<int>> OUTPUT (0,vector<int>(0,0));
 
void dfs(int edge, vector<int>& used, vector<vector<int>>& adj,
         int components)
{
 
    used[edge] = 1;
 
    for (auto nb : adj[edge])
    {
        if (!used[nb])
        {
            OUTPUT[components - 1].push_back(nb);
            dfs(nb, used, adj, components);
        }
    }
}
 
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int components = 0;
    int edges = 0; cin >> edges;
    int vertices = 0; cin >> vertices;
    vector<vector<int>> adj (edges + 1, vector<int>(0,0));
    vector<int> used(edges + 1, 0);
 
 
    for (int itt = 0; itt < vertices; itt++)
    {
        int a = 0; int b = 0; cin >> a >> b;
        adj[a].push_back(b); adj[b].push_back(a);
    }
 
    for (int edge = 1; edge <= edges; edge++)
    {
        if(!used[edge])
            {
                components++;
                OUTPUT.resize(components);
                OUTPUT[components - 1].push_back(edge);
                dfs(edge, used, adj, components);
            }
    }
 
    cout << components << '\n';
 
    for (auto component : OUTPUT)
    {
        cout << component.size() << '\n';
 
        for (int itt = 0; itt < component.size(); itt++)
        {
            cout << component[itt] << " ";
        }
 
        cout << '\n';
    }
 
 
    return 0;
}