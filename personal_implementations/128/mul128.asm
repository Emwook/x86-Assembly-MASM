.686
.model flat
public _mul_24
extern _shl_128:proc
extern _malloc:proc

.code
_mul_24 PROC
	push ebp
	mov ebp, esp
	push esi
	push ecx
	push edx
	push edi

	mov esi,[ebp+8]
	mov edi,[ebp+12]

	mov eax, [esi]
    mov [edi], eax
    mov eax, [esi+4]
    mov [edi+4], eax
    mov eax, [esi+8]
    mov [edi+8], eax
    mov eax, [esi+12]
    mov [edi+12], eax

	mov eax, [esi]
    add [edi], eax
    mov eax, [esi+4]
    adc [edi+4], eax
    mov eax, [esi+8]
    adc [edi+8], eax
    mov eax, [esi+12]
    adc [edi+12], eax

	mov eax, [esi]
    add [edi], eax
    mov eax, [esi+4]
    adc [edi+4], eax
    mov eax, [esi+8]
    adc [edi+8], eax
    mov eax, [esi+12]
    adc [edi+12], eax

	mov ecx,3
	push ecx
	push edi
	call _shl_128
	add esp,8

	pop edi
	pop edx
	pop ecx
	pop esi
	pop ebp
	ret
_mul_24 ENDP
END