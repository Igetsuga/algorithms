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
vvi ADJ;      // матрица смежности


void bfs(int point)
{
    std::queue<int> line;

    line.push(point);
    USED[point] = 1;

    while (!line.empty())
    {
        int node_current = line.front();
        line.pop();

        for (auto nb : ADJ[node_current])
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
        int node_source = 0; cin >> node_source;
        int node_target = 0; cin >> node_target;

        ADJ[node_source].push_back(node_target);
        ADJ[node_target].push_back(node_source);
   }


   for (int point = 0; point < edges; point++)
   {
        if (!USED[point])
        {
            bfs(point);
        }
   }

    return 0;
}
