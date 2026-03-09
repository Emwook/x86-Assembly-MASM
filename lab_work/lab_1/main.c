#include <stdio.h>
extern void* occurences(void* table, unsigned int n);
int main() {
	char tab[20] = { 1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 8, 9, 10, 11, 12, 13, 3, 4, 5, 6 };
	int* ptr = occurences(tab, 20);
	return 0;
}