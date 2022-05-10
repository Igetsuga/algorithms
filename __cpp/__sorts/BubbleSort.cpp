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



void BubbleSort(vi& vector_)
{
    bool permutation = false;
    for (int itt = 0; itt < vector_.size() - 1; itt++)
    {
        for (int jtt = 0; jtt < vector_.size() - 1 - itt; jtt++)
        {
            if (vector_[jtt] > vector_[jtt + 1])
            {
                std::swap(vector_[jtt], vector_[jtt + 1]);
                permutation = true;
            }
        }
        if (!permutation) { break; }
    }
}
 

 
int main()
{

    vi unsorted_vector = {68, 6, 80, 84, 41, 58, 46, 80, 68, 40, 52, 45, 5, 19, 42, 89, 58, 95, 19, 1, 67, 2, 79, 34, 49, 25, 93, 50, 39, 90, 5, 15, 33, 32, 84, 56, 68, 84, 23, 21, 99, 57, 1, 37, 26, 77, 83, 77, 35, 51, 31, 50, 6, 45, 92, 94, 48, 61, 90, 20, 36, 62, 29, 7, 26, 21, 97, 75, 33, 64, 37, 13, 52, 37, 68, 56, 88, 50, 77, 39, 31, 69, 45, 15, 53, 89, 19, 41, 54, 63, 99, 82, 70, 1, 82, 69, 11, 2, 94, 1};
    BubbleSort(unsorted_vector);

    cout << (bool) is_sorted( std::begin(unsorted_vector), std::end(unsorted_vector) ) 
        << '\n'; 


    return 0;
} 
