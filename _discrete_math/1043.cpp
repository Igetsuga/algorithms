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
 
int n; int m; 
 
vector<vector<char>> matrix;
void bfs(int &row, int &col)
{
    if (matrix[row][col] != '*') { return; }
    // из первой строки и последний не нужно запускть, т.к. если там что-то есть
    // то мы пройдемся по ним во второй и предпоследней
    if (row < 0 || col < 0 || col >= m || row >= n) { return; }
 
    std::queue<std::pair<int,int>> line;
    line.push( std::make_pair(row,col) );
    matrix[row][col] = '0';
 
    while ( !line.empty() )
    {
        std::pair<int,int> current = line.front();
        line.pop();
        int row_ = current.first; int col_ = current.second; 
        if (row_ - 1 >= 0 && matrix[row_ - 1][col_] == '*' ) { matrix[row_ - 1][col_] = '0'; line.push( std::make_pair(row_ - 1,col_) ); } 
        if (row_ + 1 < n && matrix[row_ + 1][col_] == '*') { matrix[row_ + 1][col_] = '0'; line.push( std::make_pair(row_ + 1,col_) ); }
        if (col_ + 1 < m && matrix[row_][col_ + 1] == '*') { matrix[row_][col_ + 1] = '0'; line.push( std::make_pair(row_,col_ + 1) ); }
        if (col_ - 1 >= 0 && matrix[row_][col_ - 1] == '*') { matrix[row_][col_ - 1] = '0'; line.push( std::make_pair(row_,col_ - 1) ); }
    }
}
 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
 
 
int main()
{
 
    cin >> n >> m;
 
    matrix.resize( n, vector<char> (m) );
 
    for (int itt = 0; itt < n; itt++)
    {
        for (int jtt = 0; jtt < m; jtt++)
        {
            cin >> matrix[itt][jtt];
        }
    }
 
    int constellations = 0;
    for (int itt = 0; itt < n; itt++)
    {
        for (int jtt = 0; jtt < m; jtt++)
        {
            if (matrix[itt][jtt] == '*')
            {
                constellations++;
                bfs(itt, jtt);
            }
        }
    }
 
    cout << constellations << '\n';
 
 
    return 0;
}