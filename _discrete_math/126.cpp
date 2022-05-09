#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);
    int squares; cin >> squares;
    int path_value = 10000000;
    vector<vector<int> > matrix (squares, vector<int>(squares, 0));
    int currentValue;
    for (int i = 0; i < squares; i++)
    {
        for (int j = 0; j < squares; j++)
        {
            cin >> currentValue;
            matrix[i][j] = currentValue;
        }
    }
 
    for (int point1 = 0; point1 < squares - 2; point1++)
    {
        for (int point2 = point1 + 1; point2 < squares - 1; point2++)
        {
            for (int point3 = point2 + 1; point3 < squares; point3++)
            {
                int currentPath_value = matrix[point1][point2] + matrix[point2][point3] + matrix[point3][point1];
                path_value =  ( currentPath_value < path_value ) ? currentPath_value : path_value;
            }
        }
    }
 
    cout << path_value << '\n';
 
    return 0;
}