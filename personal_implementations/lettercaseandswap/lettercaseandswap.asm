.686
.model flat
extern __write:proc
extern __read:proc
extern _calloc:proc
extern _free:proc

.code
_main proc
	push ebp
	mov ebp, esp
	sub esp,40

	push ebx
	push edi
	push esi

	push 1
	mov eax,120
	push eax
	call _calloc
	add esp,8
	mov edi, eax

	push 1
	mov eax,120
	push eax
	call _calloc
	add esp,8
	mov esi, eax

	push 60
	push esi
	push 0
	call __read
	add esp,12

	mov ebx,edi
	mov edi,esi
	
	push ebx

	mov edx, edi
	xor ecx,ecx

	petla:
		xor eax,eax
		mov al, [edx+ecx]
		test al,al
		jz koniec

		cmp al,13
		je pomin
		cmp al,10
		je pomin

		sub al,20H

		pomin:
		mov [edx+ecx],al
		inc ecx
		jmp petla

	koniec:
	xor edi,edi
	dec ecx

	odwrotnie:

		cmp edi,ecx
		jge dalej

		mov al,[edx+ecx]
		mov bl,[edx+edi]

		mov [edx+ecx],bl
		mov [edx+edi],al

		dec ecx
		inc edi
		jmp odwrotnie

	dalej:
	push 60
	push esi
	push 1
	call __write
	add esp,12

	pop edi
	pop ebx
	mov edi,ebx

	push edi
	call _free
	add esp,4

	push esi
	call _free
	add esp,4

	pop esi
	pop edi
	pop ebx

	add esp,40 
	pop ebp
	ret
_main endp
end
