#include <stdio.h>

extern void kolo(float r, float* pole, float* obwod);

int main() {
    float r, wynik_pole, wynik_obwod;

    printf("Podaj promien r: ");
    scanf_s("%f", &r);

    kolo(r, &wynik_pole, &wynik_obwod);

    printf("pole kola = %f, dlugosc kola = %f\n", wynik_pole, wynik_obwod);

    return 0;
}