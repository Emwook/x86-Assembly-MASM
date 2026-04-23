#include <stdio.h>

extern float srednia_harm(int* tab, int n);

int main() {
    int n;

    printf("Enter number of elements: ");
    scanf_s("%d", &n);

    if (n <= 0) {
        printf("Invalid number of elements.\n");
        return 1;
    }

    int tablica[100];
    if (n > 100) {
        printf("Maximum allowed is 100.\n");
        return 1;
    }

    for (int i = 0; i < n; i++) {
        printf("Enter element %d: ", i + 1);
        scanf_s("%d", &tablica[i]);
        if (tablica[i] == 0) {
            printf("Element cannot be zero for harmonic mean.\n");
            return 1;
        }
    }

    float wynik = srednia_harm(tablica, n);

    printf("Harmonic mean = %f\n", wynik);

    return 0;
}
