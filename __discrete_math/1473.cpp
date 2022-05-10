#pragma GCC optimize("Ofast")
//#include <bits/stdc++.h>
 #include <iostream>
 #include <vector>
 #include <algorithm>
 #include <string>
 #include <bitset>
 #include <map>
 #include <unordered_map>
 #include <stack>
 #include <queue>
 #include <numeric>
 #include <iterator>
 #include <math.h>
 #include <set>
 #include <functional>
 #include <fstream>
 #include <chrono>
 #include <random>
 #include <assert.h>
 
#define all(x) begin(x), end(x)
 
using std::cin;
using std::cout;
using std::vector;
using std::string;
 
using ll = long long;
using vi = vector<int>;
using vvi = vector<vi>;
 
 
const ll mod = ll(1e9 + 7);
 
 
const auto ready = []()
{
    cin.tie(0);
    std::ios_base::sync_with_stdio(false);
    return true;
}();
 
 
void print_(const std::set<int>& set)
{
    cout << set.size() << '\n';
    for (auto element : set)
    {
        cout << element << " ";
    }
    cout << '\n';
}
 
 
////////////////////////////////////////////////////////////////////////////////
 
vvi adj;
vi used;
 
void dfs(int node, std::set<int>& set)
{
    used[node] = (used[node] == -1) ? -1 : 1;
 
    set.insert(node);
    for (auto nb : adj[node])
    {
        if (used[nb] != 1 && used[nb] != -1) { dfs(nb, set); }
    }
 
 
}
 
 
////////////////////////////////////////////////////////////////////////////////
 
 
int main()
{
 
    int cites; cin >> cites;
    int edges; cin >> edges;
 
    adj.resize(cites + 1);
    used.resize(cites + 1);
 
    for (int edge = 0; edge < edges; edge++)
    {
        int point_1, point_2; cin >> point_1 >> point_2;
        adj[point_1].push_back(point_2);
        adj[point_2].push_back(point_1);
    }
 
 
    int bigO = 0; cin >> bigO;
    vi kings(bigO);
 
    for (int itt = 0; itt < bigO; itt++)
    {
        int capital = 0; cin >> capital;
        kings.push_back(capital);
        used[capital] = -1;
    }
 
    std::set<int> s_king;
 
    for (auto king : kings)
    {
        if (king)
        {
            dfs(king, s_king);
 
            print_(s_king);
            s_king.clear();
        }
    }
 
 
    return 0;
}