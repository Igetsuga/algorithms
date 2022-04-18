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


vi random_vector(int number)
{

    vi vector(number,0);

    for (int itt = 0; itt < number; itt++)
    {
        vector[itt] = std::rand();
    }

    return vector;
}

////////////////////////////////////////////////////////////////////////////////

void InsertionSort( vi& vector_unsorted )
{
    for (int itt = 1; itt < vector_unsorted.size(); itt++)
    {
        while (itt > 0 && vector_unsorted[itt] < vector_unsorted[itt - 1])
        {
            int value_temp = vector_unsorted[itt - 1];

            vector_unsorted[itt - 1] = vector_unsorted[itt];
            vector_unsorted[itt] = value_temp;

            itt--;
        }
    }
}



int main()
{
    srand(time(NULL)); // для генарации вектора с разными значениями на каждой 
                       // запуске программы

    vi unsorted_vector = random_vector(100);

    InsertionSort(unsorted_vector);

    // print_(unsorted_vector);

    cout << (bool) is_sorted( std::begin(unsorted_vector), std::end(unsorted_vector) ) 
        << '\n'; // провека работы сортировки

    print_(unsorted_vector);

    return 0;
}
