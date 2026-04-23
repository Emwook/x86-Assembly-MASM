.686
.model flat
public _palindrom
extern _malloc:proc

.code
_palindrom PROC
	push ebp
	mov ebp, esp
	sub esp,8

	push esi
	push edi
	push edx
	push ebx
	push ecx

	mov eax,0
	mov ecx, 0FFFFFFFFh
	mov edi, [ebp+8]

	repne scasw
	neg ecx
	sub ecx,2

	mov eax,ecx
	mov ebx,2
	mul ebx
	push eax
	call _malloc
	add esp,4
	mov [ebp-4],eax
	xor ecx,ecx
	mov [ebp-8],ecx
	xor ebx,ebx
	mov esi,[ebp+8]

	petla:
	mov eax, esi
	sub eax,ebx
	mov edi,[eax]
	cmp di,0
	jz koniec

	mov edi,edx
	mov eax,esi
	add eax,ebx
	add eax,2
	mov edi, [eax]
	cmp di,0
	jz koniec

	mov eax,edi
	jz takie_same

	mov edi,0
	cmp ebx,edi
	jae zapis

	add ecx,2
	jmp petla
	
	takie_same:
	add ebx,2
	jmp petla

	zapis:
	push edx
	push ebx
	mov eax,ebx
	inc eax
	mov edi,2
	mov edx,0
	mul edi
	mov edx,eax

	push eax
	call _malloc
	add esp,4

	mov edi,eax
	pop edx
	mov ecx,edx
	inc ecx
	rep movsw
	mov ebx, [ebp-4]
	mov eax, [ebp-8]
	add ebx,eax
	mov [ebx],edx
	mov [ebx+4],edi
	add eax,8
	mov [ebp-8],eax
	pop ebx
	add ecx,2
	mov ebx,0
	jmp petla

	koniec:
	mov eax,[ebp-4]

	pop ecx
	pop ebx
	pop edx
	pop edi
	pop esi
	
	add esp,8
	pop ebp
	ret
_palindrom endp
end
