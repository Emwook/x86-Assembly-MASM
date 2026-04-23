.686
.model flat
public _liczba_przeciwna
.code
_liczba_przeciwna PROC
	push ebp ; zapisanie zawartości EBP na stosie
	mov ebp, esp ; kopiowanie zawartości ESP do EBP
	push ebx

	mov ebx, [ebp+8]     ; address of the integer variable
    mov eax, ebx       ; load its value
    neg eax               ; negate (eax = -eax)

	pop ebx
	pop ebp
	ret

_liczba_przeciwna ENDP
 END
