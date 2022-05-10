#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
 
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int edges; cin >> edges;
    int roads; cin >> roads;
 
    set<pair<int,int> > graph;
 
    for (int itt = 0; itt < roads; itt++) {
        int edge_1, edge_2; cin >> edge_1 >> edge_2;
        if (edge_2 > edge_1) swap(edge_1, edge_2);
        graph.insert(pair<int,int> (edge_1, edge_2));
    }
 
//    cout << graph.size() << '\n';
 
    if (graph.size() >= edges) { cout << "YES" << '\n';}
    else {cout << "NO" << '\n';}
 
 
 
//    for (auto element : graph) {
//        cout << element.first << " : " << element.second << '\n';
//    }
    return 0;
}