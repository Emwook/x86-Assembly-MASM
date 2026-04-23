#include <stdio.h>
extern void dodaj_SSE(char* a, char* b, char* wynik);

int main()
{
    char liczby_A[16] = {
        -128, -127, -126, -125, -124, -123, -122, -121,
         120,  121,  122,  123,  124,  125,  126,  127
    };

    char liczby_B[16] = {
        -3, -3, -3, -3, -3, -3, -3, -3,
         3,  3,  3,  3,  3,  3,  3,  3
    };

    char wynik[16];

    dodaj_SSE(liczby_A, liczby_B, wynik);

    printf("Indeks\t A \t B \tWynik (SSE)\tWynik Matematyczny\n");
    printf("-----------------------------------------------------------\n");

    for (int i = 0; i < 16; i++)
    {
        int a = (int)liczby_A[i];
        int b = (int)liczby_B[i];
        int res = (int)wynik[i];
        int math = a + b;

        printf("[%d]\t%d\t%d\t%d\t\t%d", i, a, b, res, math);

        if (res != math) {
            printf("\t <--- NASYCENIE (Blad pozorny)");
        }
        printf("\n");
    }

    return 0;
}