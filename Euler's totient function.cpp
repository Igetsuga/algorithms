#pragma GCC optimize("Ofast")
#include <bits/stdc++.h>
using namespace std;

bool prime(int64_t n)
{
    int64_t itt = sqrt(n) + 1;
    for (int64_t i = 2; i < itt; i++)
    {
        if (!(n % i)) return false;
    }
    return true;
}

int64_t phi(int64_t value)
{
    if (!prime(value)) {
        int64_t phi = value;
        int64_t itt = sqrt(value) + 1;

        for (int64_t i = 2; (i <= itt) and (value >= i) ;i++)
        {
           if (value % i == 0)
            {
            phi -= phi/i; // phi - ���������� ������������� � value ������
            // �������, ������� ��� ������� ������ ������, ����� ������ ������ � ��, ��
            // ����� � �������� ������ ������, � ���� ������� 6, 12, 18... ��������,
            // ������� ����� ��������� phi -= phi/i;, � �� phi -= value/i;
            while (value % i == 0) value /= i; // ���� ��� ���������� �� 2, �� ����� ���
            // ��� ������� �� ��������� �� �� 4, �� �� 6 ...
            }
        }
        if (value > 1) // �������� ������� ��������, ������� �����(���� �� ����, �� ������ ����)
        {
            phi = phi - phi/value;
        }
        return phi;
    }
    else return (value - 1);
}

int main()
{
    ios::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL);

    cout << phi(560) << '\n';
    cout << phi(8430500) << '\n';
    cout << phi(21899591001) << '\n';
    cout << phi(68719476736) << '\n';
    cout << phi(99108452070) << '\n';

    return 0;
}





