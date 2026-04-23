#include <stdio.h>

extern float nowy_exp(float x);

int main() {
    float x = 1.0f;

    printf("Obliczam sume szeregu x^i / i! dla x=%.2f i n=%d\n", x, 20);

    float wynik = nowy_exp(x);

    printf("Wynik: %.6f\n", wynik);

    return 0;
}