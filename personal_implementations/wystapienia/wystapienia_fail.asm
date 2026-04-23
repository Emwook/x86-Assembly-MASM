.686
.model flat
extern _calloc:proc
public _wystapienia

.code
_wystapienia proc
	push ebp
	mov ebp, esp
	sub esp,4

	push ebx
	push edi
	push esi

	mov eax,[ebp+12]
	mov ebx,5
	mul ebx
	push 4
	push eax
	call _calloc
	add esp,8

	mov [ebp-4],eax
	dec dword ptr [ebp+12]
	xor ecx,ecx

	petla_zewn:
		mov edx,[ebp-4]
		xor eax,eax
		mov al, byte ptr [edx]
		mov edx,ecx

		petla_wewn:
			mov ebx,[ebp-4]
			add ebx,edx
			mov edi,ebx
			mov bl,byte ptr [edi]

			cmp bl,al
			jnz zacnie
				
			lea edi, [ecx+4*ecx]
			mov esi, [ebp-4]
			add edi, esi
			cmp byte ptr [edi], bl
			jz superancko
			mov byte ptr [edi], bl

			superancko:
				inc edi
				inc dword ptr [edi]

			zacnie:
				cmp ecx, [ebp+12]
				jb koniec
				cmp edx, [ebp+12]
				jb dalej_krecimy
				inc ecx
				;inc byte ptr [ebp-4]
				jmp petla_zewn

			dalej_krecimy:
				inc edx
				jmp petla_wewn

	koniec:
		mov eax,[ebp-4]
		mov [ebp+8], eax

	pop esi
	pop edi
	pop ebx

	add esp,4 
	pop ebp
	ret
_wystapienia endp
end
