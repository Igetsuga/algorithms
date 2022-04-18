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
        cout << element << " : " ;
    }

    cout << "<<<" <<'\n';
}


////////////////////////////////////////////////////////////////////////////////


vi USED(0,0); // вектор, хранящий вершины, в которых мы уже были
vvi ADJ; // матрица смежности


void bfs(int edge)
{
    std::queue<int> line;

    line.push(edge);
    USED[edge] = 1;

    while (!line.empty())
    {
        int edge_current = line.front();
        line.pop();

        for (auto nb : ADJ[edge_current])
        {
            if (!USED[nb])
            {
                USED[nb] = 1;
                line.push(nb);
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////


int main()
{
   int edges;
   int input_;

   //USED.resize(edges); // не знаю зачем это нужно
   //ADJ.resize(edges);  // не знаю зачем это нужно

   for (int itt = 0; itt < input_; itt++)
   {
        int edge = 0; cin >> edge;
        int edge_n = 0; cin >> edge_n;

        ADJ[edge].push_back(edge_n);
        ADJ[edge_n].push_back(edge);
   }


   for (int edge = 0; edge < edges; edge++)
   {
        if (!USED[edge])
        {
            bfs(edge);
        }
   }

    return 0;
}
