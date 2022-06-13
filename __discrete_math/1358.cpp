#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
// #include <iostream>
// #include <vector>
// #include <algorithm>
// #include <string>
// #include <bitset>
// #include <map>
// #include <unordered_map>
// #include <stack>
// #include <queue>
// #include <numeric>
// #include <iterator>
// #include <math.h>
// #include <set>
// #include <functional>
// #include <fstream>
// #include <chrono>
// #include <random>
// #include <assert.h>
 
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
 
 
void print_(const vi& vector)
{
    cout << '\n' << ">>> : ";
 
    for (auto element : vector)
    {
        cout << element << " : ";
    }
 
    cout << "<<<" << '\n';
}
 
 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
 
int test()
{
    int nodes; cin >> nodes; 
    int edges; cin >> edges;
    vector<vector<int>> adj_matrix (nodes + 1, vector<int> (nodes + 1, 0));

    int count_edges = 0;

    for (int edge = 1; edge <= edges; edge++)
    {
        int node_1; cin >> node_1;
        int node_2; cin >> node_2;
        
        if (adj_matrix[node_1][node_2] == 0 && adj_matrix[node_2][node_1] == 0)
        {
            count_edges += 1;
        }

        adj_matrix[node_1][node_2] = 1;
        adj_matrix[node_2][node_1] = 1;
    }
        
    return { count_edges == (nodes * (nodes - 1) / 2) };
}

int main()
{
    int answer = test();

    cout << ( (answer == 1) ? "YES" : "NO" );

    return 0;

}