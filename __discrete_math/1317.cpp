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
  
  
void dfs(int edge, vvi& adj, vi& used)
{
    used[edge] = 1;
    for (auto nb : adj[edge])
    {
        if (!used[nb]) { dfs(nb, adj, used); }
    }
}
  
  
  
int main()
{
  
  
    int rows = 0; int columns = 0; cin >> rows >> columns;
  
    vvi adj(rows * columns + 1);
    vi used(rows * columns + 1, 0); used[0] = 1;
    vvi matrix(rows + 1, vi(columns + 1, 0));
  
    int edge_current = 1;
  
    for (int row = 1; row <= rows; row++)
    {
        for (int column = 1; column <= columns; column++)
        {
            char c; cin >> c;
            if (int(c) == 35)
            {
                matrix[row][column] = 1;
  
                if (edge_current > 8)
                {
                    if ( matrix[row - 1][column] == 1 )
                    {
                        adj[edge_current - columns].push_back(edge_current);
                        adj[edge_current].push_back(edge_current - columns);
                    }
                }
  
                if (edge_current % columns != 1)
                {
                   if ( matrix[row][column - 1] == 1 )
                    {
                        adj[edge_current - 1].push_back(edge_current);
                        adj[edge_current].push_back(edge_current - 1);
                    }
                }
  
            }
            else { used[edge_current] = 1; }
            edge_current++;
        }
    }
  
    int result = 0;
  
    for (int itt = 1; itt < edge_current; itt++)
    {
        if (!used[itt]) { result++; dfs(itt, adj, used); }
  
    }
  
    cout << result << '\n';
 
 
// Идея. Идея была точно такая же, что и в разборе от АВ - запускать dfs из каждой клетки
//       и считать число запусков, т.к. запуск dfs из конкретной клетки полностью обходил 
//       1 компоненту связности.
 
// В чем была ошибка? В сторочках 75, 79, 80, 84 вместо `columns` стояло конкретное число - 8.
//                    Очевидно, почему это было не корректно для случаев, когда число столбцов
//                    не равняется 8.
  
  
    return 0;
}