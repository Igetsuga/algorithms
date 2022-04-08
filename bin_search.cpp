#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;


int bin_search(const vector<int>& vv, int value)
{
    int itt_right = vv.size() - 1;
    int itt_left = 0;
    int itt_middle = 0;

    if (vv[itt_left] == value) { return itt_left; }
    if (vv[itt_right] == value) { return itt_right; }

    while (itt_left <= itt_right) {

        itt_middle = itt_left + ( (itt_right - itt_left) / 2 );

        if (vv[itt_middle] == value) { return itt_middle; }
        else if (vv[itt_middle] > value) { itt_right = itt_middle - 1; }
        else { itt_left = itt_middle + 1; }
    }
}



int main()
{
    vector<int> array_(0,0);
    for (int itt = 0; itt < 101; itt++)
    {
        array_.push_back(itt);
    }

    cout << "\n" << typeid(array_).name() << " size: " << array_.size() << ", capacity: " << sizeof(array_)
			<< '\n' <<"elements: { >> ";
		for (int itt = 0; itt < array_.size(); itt++)
		{
			// cout << ': ' << array_[itt];
			cout << ": " << array_[itt] << " ";
		}
		cout << ": << }" << '\n';


    int value; cin >> value;

    cout << bin_search(array_, value) << '\n';

    return 0;
}


