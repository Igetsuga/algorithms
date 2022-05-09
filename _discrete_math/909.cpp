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
 
int n = 0; int m = 0;
int ships_S = 0;
int ships_X = 0;
int ships__ = 0;
 
vector<vector<char>> matrix;
 
 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
void bfs(const int& row, const int& col, const char& symbol)
{
    std::queue<std::pair<int, int>> line;
    line.push(std::make_pair(row, col));
    matrix[row][col] = '0';
 
    char anti_symbol = (symbol == 'S') ? 'X' : 'S';
    int flag = 0;
 
    while (!line.empty())
    {
        int row_ = line.front().first;
        int col_ = line.front().second;
        line.pop();
 
        if (row_ - 1 >= 0 && (matrix[row_ - 1][col_] == symbol || matrix[row_ - 1][col_] == anti_symbol))
        {
            if (!flag) { flag = (matrix[row_ - 1][col_] == symbol) ? 0 : 1; }
 
            line.push(std::make_pair(row_ - 1, col_));
            matrix[row_ - 1][col_] = '0';
        }
 
        if (row_ + 1 < n && (matrix[row_ + 1][col_] == symbol || matrix[row_ + 1][col_] == anti_symbol))
        {
            if (!flag) { flag = (matrix[row_ + 1][col_] == symbol) ? 0 : 1; }
 
            line.push(std::make_pair(row_ + 1, col_));
            matrix[row_ + 1][col_] = '0';
        }
 
        if (col_ + 1 < m && (matrix[row_][col_ + 1] == symbol || matrix[row_][col_ + 1] == anti_symbol))
        {
            if (!flag) { flag = (matrix[row_][col_ + 1] == symbol) ? 0 : 1; }
 
            line.push(std::make_pair(row_, col_ + 1));
            matrix[row_][col_ + 1] = '0';
        }
 
        if (col_ - 1 >= 0 && (matrix[row_][col_ - 1] == symbol || matrix[row_][col_ - 1] == anti_symbol))
        {
            if (!flag) { flag = (matrix[row_][col_ - 1] == symbol) ? 0 : 1; }
 
            line.push(std::make_pair(row_, col_ - 1));
            matrix[row_][col_ - 1] = '0';
        }
    }
 
    if (flag) { ships__++; }
    else { (symbol == 'X') ? ships_X++ : ships_S++; }
}
 
int main()
{
 
    cin >> n >> m;
 
    matrix.resize(n, vector<char>(m));
 
    for (int itt = 0; itt < n; itt++)
    {
        for (int jtt = 0; jtt < m; jtt++)
        {
            cin >> matrix[itt][jtt];
        }
    }
 
 
 
    for (int itt = 0; itt < n; itt++)
    {
        for (int jtt = 0; jtt < m; jtt++)
        {
            if (matrix[itt][jtt] == 'S')
            {
                bfs(itt, jtt, 'S');
            }
            else if (matrix[itt][jtt] == 'X')
            {
                bfs(itt, jtt, 'X');
            }
        }
    }
 
    cout << ships_S << " " << ships__ << " " << ships_X << '\n';
 
 
    return 0;
}