#include <stdio.h>
#include <windows.h>

void przestaw(int* tab, int n);

int main(void)
{
    SetConsoleOutputCP(CP_UTF8);

    int tab[] = { 5, 1, 8, 3, 2 };
    int n = sizeof(tab) / sizeof(tab[0]);

    printf("Przed sortowaniem:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", tab[i]);
    printf("\n");

    for (int i = n; i > 1; i--)
        przestaw(tab, i);

    printf("Po sortowaniu:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", tab[i]);
    printf("\n");

    return 0;
}
