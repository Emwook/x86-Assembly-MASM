#include <stdio.h>
#include <windows.h>
int liczba_przeciwna (int a);
int main()
{
int x;
int wynik;
 SetConsoleOutputCP(CP_UTF8);
 printf("\nProszę podać liczbe: ");
 scanf_s("%d", &x, 32);
 wynik = liczba_przeciwna(x);
 printf("\n liczba odwrotna do \
 liczby %d to %d\n", x, wynik);
 return 0;
}
