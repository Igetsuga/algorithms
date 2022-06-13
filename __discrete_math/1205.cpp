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

int main()
{
	int nodes; cin >> nodes;
	int deg_current = 0; int deg_prev = 0; bool flag = true;


	for (int itt = 0; itt < nodes; itt++)
	{

		deg_current = 0;
		for (int jtt = 0; jtt < nodes; jtt++)
		{
			int is_edge = 0; cin >> is_edge;
			deg_current += is_edge;
		}
		
		if (itt == 0) { deg_prev = deg_current; }
		else 
		{
			if (deg_current - deg_prev != 0) { cout << "NO"; flag = false; break; }
			else {deg_prev = deg_current;}
		}
	}
		
	if (flag) { cout << "YES"; }

	return 0;
}


// for (int itt = 0; itt < 4; itt++)
// {
//     // adj[rr][cc] is a neighbour of a adj[r][c]
//     int rr = r + dr[itt];
//     int cc = c + dc[itt];

// }

// for (int i = 0; i < 4; i++)
// {
//     // adj[rr][cc] is a neighbour of a adj[r][c]
//     int rr = r + dr[i];
//     int cc = c + dc[i];

//     // checking if [rr][cc] is out of bounds
//     if (rr < 0 || rr >= nodes) { continue; }
//     if (cc < 0 || cc >= nodes) { continue; }

// }


//   // for (auto el : adj_matrix)
//     // {
//     //     print_(el);
//     // }