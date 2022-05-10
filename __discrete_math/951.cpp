#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
 
    int rows, colums; cin >> rows >> colums;
    //vector<vector<int> > matrix(rows, vector<int>(colums, 0));
    int viruses; cin >> viruses;
    vector<pair<int,int> > matrix( viruses, pair<int, int> (0,0) );
    int x, y;
    for (int i = 0; i < viruses; i++)
    {
        cin >> x; cin >> y;
        matrix[i] = make_pair(x,y);
    }
 
    int distance_max = 0;
    int distance_temp = 0;
    int distance_min_temp = 100000;
    int answer = 0;
 
    for (int row = 1; row <= rows; row++)
    {
        distance_temp = 0;
        distance_min_temp = 1000000;
 
        for (int colum = 1; colum <= colums; colum++)
        {
            for (auto pr : matrix)
            {
                int distance = abs(row - pr.first) + abs(colum - pr.second);
                distance_temp += distance;
                distance_min_temp = (distance < distance_min_temp) ? distance : distance_min_temp;
            }
            if (  answer <= distance_min_temp )
            {
 
                answer = distance_min_temp;
            }
            distance_temp = 0;
            distance_min_temp = 1000000;
        }
    }
 
 
 
    cout << answer << '\n';
 
/*
    pair<int, int> s1 (0,0);
    pair<int, int> s2 (1,2);
    s1 = make_pair(9,13214);
    cout << s1.first << ' ' << s1.second << '\n';
*/
    return 0;
}