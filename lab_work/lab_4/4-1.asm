.686
.model flat
public _szukaj_max
.code
_szukaj_max PROC
	push ebp ; zapisanie zawartości EBP na stosie
	mov ebp, esp ; kopiowanie zawartości ESP do EBP

	porownanie_1:
		mov eax, [ebp+8] ; liczba x
		cmp eax, [ebp+12] ; porownanie liczb x i y
		jge x_wieksza ; skok, gdy x >= y
		mov ebx, [ebp+12] ; wpis y do ebx gdy x<y
		jmp porownanie_2

	x_wieksza:
		mov ebx,eax
		jmp porownanie_2

	porownanie_2:
		mov eax, [ebp+16] ; liczba z
		cmp eax, [ebp+20] ; porownanie liczb z i w
		jge porownanie_3 ; skok, gdy z >= w
		mov eax, [ebp+20] ; wpis w do ebx gdy z<w
		jmp porownanie_3

	porownanie_3:
		cmp eax, ebx ; czy druga wieksza > pierwsza wieksza
		jbe najwieksza_xy ; skok, gdy (x lub y) > (w lub z)

	najwieksza_xy: 
		mov eax, ebx ; liczba x lub y
		jmp zakoncz

	zakoncz:
		pop ebp
		ret

_szukaj_max ENDP
END