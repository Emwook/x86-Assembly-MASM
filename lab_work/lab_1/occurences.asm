.686
.model flat
extern _malloc : PROC
public _occurences

.code
_occurences PROC
	push ebp
	mov ebp,esp

	push edi
	push esi
	push ebx
	push edx

	mov edi, [ebp+8]   ; edi = source string
	mov esi, [ebp+12]  ; esi = length

	mov eax, 5
	mul esi
	push eax
	call _malloc
	add esp, 4         ; eax = pointer to new memory

	mov ebx, eax       ; ebx = pointer to new memory
	mov edx, 0         ; edx = i (outer loop)

	abc:
		; 1. Calculate the start of the current 5-byte block
		; We use 'push eax' to save the malloc pointer while we calculate
		push eax
		imul eax, edx, 5   ; offset = i * 5
		
		; 2. Copy source[i] to new_memory[i*5]
		mov cl, [edi+edx]  ; load character into 8-bit register
		mov [ebx+eax], cl  ; store character
		
		; 3. Initialize counter to 0
		mov dword ptr [ebx+eax+1], 0
		pop eax

		; 4. Reset inner loop counter
		mov ecx, esi       ; ecx = j (inner loop)

	inner_loop:
		; Compare character at source[edx] with source[ecx-1]
		mov al, [edi+edx]
		mov ah, [edi+ecx-1]
		cmp al, ah
		jne next
		
		; If match, increment the dword counter at ebx + (edx*5) + 1
		push eax
		imul eax, edx, 5
		inc dword ptr [ebx+eax+1]
		pop eax

	next:
		dec ecx
		jnz inner_loop        ; finish checking all j for this i
		
		inc edx
		cmp edx, esi
		jb abc                ; move to next i

	koniec:
	mov eax, ebx
	pop edx
	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_occurences ENDP
END