#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
void dfs(int edge, vector<int>& used, vector<vector<int>>& matrix)
{
    used[edge] = 1;
    for (auto nb : matrix[edge])
    {
        if (!used[nb]) { dfs(nb, used, matrix); }
    }
}
 
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int edges = 0; cin >> edges;
 
    vector<vector<int>> matrix(edges, vector<int>(0, 0));
    vector<int> used(edges, 0);
    int vertices = 0;
    int component = 0;
 
 
    for (int i = 0; i < edges; i++)
    {
        for (int j = 0; j < edges; j++)
        {
            int vertice = 0; cin >> vertice;
            if (vertice) { matrix[i].push_back(j); vertices++; }
        }
    }
 
//    for (int itt = 0; itt < edges; itt++)
//    {
//        cout << itt << " >> ";
//        for (auto element : matrix[itt])
//        {
//            cout << " : " << element;
//        }
//        cout << '\n';
//    }
 
    vertices /= 2;
    if ( vertices == (edges - 1) )
    {
        for (int edge = 0; edge < edges; edge++)
        {
            if (!used[edge]) { component++, dfs(edge, used, matrix); }
        }
 
        if ( component == 1 ) { cout << "YES" << '\n'; }
        else { cout << "NO" << '\n'; }
    }
    else { cout << "NO" << '\n'; }
 
 
 
 
 
 
 
 
 
 
    return 0;
}