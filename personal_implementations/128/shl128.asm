.686
.model flat
public _shl_128

.code
_shl_128 PROC
	push ebp
	mov ebp, esp
	push esi
	push ecx
	push edx

	mov esi,[ebp+8]
	mov ecx,[ebp+12]

	petla:
		clc
		shl dword ptr [esi], 1
		rcl dword ptr [esi+4], 1
		rcl dword ptr [esi+8], 1
		rcl dword ptr [esi+12], 1
	loop petla

	pop edx
	pop ecx
	pop esi
	pop ebp
	ret
_shl_128 ENDP
END