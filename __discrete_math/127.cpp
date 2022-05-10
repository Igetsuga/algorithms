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
vvi adj_matrix(0, vector<int>(0));
vi visited(0); 
int path = 0;
 
// for counting nodes in layers
int nodes_left_in_layer = 1; // first is node_start
int nodes_in_next_layer = 0; 
 
int bfs(const int &node_start, const int &node_finish)
{
    std::queue<int> line;
    line.push(node_start);
    //visited[node_start] = 1;
    bool is_end_reached = false;
 
    while (!line.empty())
    {
        int node_current = line.front(); line.pop(); visited[node_current] = 1;
 
        if (node_current == node_finish) {is_end_reached = true; break;}
 
        // explore_neighbours(node_current);
        for (auto nb : adj_matrix[node_current])
        {
            if (!visited[nb])
            {
                line.push(nb);
                visited[nb] = 1;
                nodes_in_next_layer++;
            }
        }
 
        nodes_left_in_layer--;
         
        if (nodes_left_in_layer == 0)
        {
            nodes_left_in_layer = nodes_in_next_layer;
            nodes_in_next_layer = 0;
 
            path++;
        }
    }
 
    if (is_end_reached) { return path; }
 
 
    return -1;
}
 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
int nodes = 0; 
 
int main()
{
    cin >> nodes;
    adj_matrix.resize(nodes);
    visited.resize(nodes);
 
   // filling an adj_matrix
    for (int i = 0; i < nodes; i++)
    {
        for (int j = 0; j < nodes; j++)
        {
            int is_adj = 0; cin >> is_adj;
            if (is_adj) 
            {
                adj_matrix[i].push_back(j);
            }
        }
    }
 
    int node_start = 0; cin >> node_start; node_start--;
    int node_finish = 0; cin >> node_finish; node_finish--;
 
 
    // getting answer
    cout << bfs(node_start, node_finish) << '\n';
     
 
    return 0;
}