#pragma GCC optimize("Ofast")
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
 
// vector<vector<int>> map_(0, vector<int>(0));
vector<vector<int>> visited(8,vector<int>(8, 0)); 
vector<vector<int>> map_red(8,vector<int>(8, -1));
vector<vector<int>> map_green(8,vector<int>(8, -1)); 


int dimension = 8;

std::pair<int,int> START = std::make_pair(0,0);
std::pair<int,int> FINISH = std::make_pair(0,0);

// define directions
vector<int> dr{-2, -2, -1, -1,  1,  1,  2,  2};
vector<int> dc{-1,  1, -2,  2, -2,  2, -1,  1};
 
 
 
int bfs()
{
    int path = 0;
 
    // for counting nodes in layers
    int nodes_left_in_layer = 1; // first is node_start
    int nodes_in_next_layer = 0; 
 
    std::queue<int> rq;
    std::queue<int> cq;
 
    rq.push(START.first); cq.push(START.second);
 
    visited[START.first][START.second] = 0;
    bool is_end_reached = false;
 
    while ( !rq.empty() )
    {
        int r = rq.front(); int c = cq.front();
        rq.pop(); cq.pop();
        visited[r][c] = 1;
 
        if ( r == FINISH.first && c == FINISH.second )
        {
            is_end_reached = true;
            break;
        }
 
        // explore_neighbours(node_current);
        for (int i = 0; i < 8; i++)
        {
            int rr = r + dr[i];
            int cc = c + dc[i];
 
            if ( rr >= 8 || cc >= 8 ) { continue; }
            if ( rr < 0 || cc < 0 ) { continue; }
            if ( visited[rr][cc] != -1) { continue; }
            // if (map_[rr][cc] == '#') { continue; }
 
            rq.push(rr); cq.push(cc);
            visited[rr][cc] = 1;
            nodes_in_next_layer++;
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
 
int main()
{

    // map_.resize(dimension, vector<int>(dimension));
    // visited.resize(dimension, vector<int>(dimension));

    std::set<int> set;


    std::string coords_start;

    cin >> coords_start; 
    START = std::make_pair(int(coords_start[0]) - 96 - 1, int(coords_start[1]) - 1 - 48);
    for (int row = 0; row < dimension; row++)
    {
        for (int col = 0; col < dimension; col++)
        {
            if (map_green[row][col] == -1)
            {
                FINISH = std::make_pair(row,col);
                map_green[row][col] = bfs();
            }
        }
    }



    cin >> coords_start; vector<vector<int>> visited(8,vector<int>(8, 0));
    START = std::make_pair(int(coords_start[0]) - 96 - 1, int(coords_start[1]) - 1 - 48);
    for (int row = 0; row < dimension; row++)
    {
        for (int col = 0; col < dimension; col++)
        {
            if (map_red[row][col] == -1)
            {
                FINISH = std::make_pair(row,col);
                map_red[row][col] = bfs();
                if (map_red[row][col] == map_green[row][col]) { set.insert(map_green[row][col]); }
            }
        }
    }

    cout << *(set.begin());

    
    return 0;
}