#include <stdio.h>
int czy_pierwsza(int a);
int main()
{
	int k,j;
	printf("\nProsze napisac liczbe: ");
	scanf_s("%d", &k);
	j = czy_pierwsza(k);
	if (j == 0) {
		printf("\nnie jest pierwsza");
	}
	else {
		printf("\njest pierwsza");
	}
	return 0;
}
