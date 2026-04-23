.686
.XMM
.model flat
public _wave_calculate_next_step
extern _malloc:proc

.code
_wave_calculate_next_step PROC
	push ebp
	mov ebp,esp

	sub esp, 16

	push ebx
	push edi
	push esi

	mov edi, [ebp+8]
	mov esi, [ebp+12]
	mov ecx, [ebp+16]
	mov edx, [ebp+20]

	petla:
		movups xmm0, [edi+4*ecx]
		mov eax, 0BF800000H
		mov [ebp-4], eax ;-1
		mov [ebp-8], eax
		mov [ebp-12], eax
		mov [ebp-16], eax
		movups xmm1,[ebp-16]
		mulps xmm0,xmm1
		; XMM0 = -Y_M[N-1]

		movups xmm1,[esi+4*ecx]
		mov eax, 40000000H
		mov [ebp-4], eax ;2
		mov [ebp-8], eax
		mov [ebp-12], eax
		mov [ebp-16], eax
		movups xmm2,[ebp-16]
		mulps xmm1,xmm2
		addps xmm0,xmm1
		; XMM0 = 2Y_M[N] - Y_M[N-1]

		add edx, 800000H 
		mov [ebp-4], edx ;2r
		mov [ebp-8], edx
		mov [ebp-12], edx
		mov [ebp-16], edx
		movups xmm1, [esi+4*ecx]
		movups xmm2, [ebp-16]
		mulps xmm1,xmm2
		subps xmm0,xmm1
		; XMM0 = 2Y_M[N] - Y_M[N-1] - 2r*Y_M[N]

		mov eax,1
		cmp ecx,eax
		jle omin
		cmp ecx, [ebp+16]
		je omin

		movups xmm1, [esi+4*ecx+4]
		sub edx, 800000H
		mov [ebp-4], edx ;r
		mov [ebp-8], edx
		mov [ebp-12], edx
		mov [ebp-16], edx
		movups xmm2, [ebp-16]
		mulps xmm1,xmm2
		addps xmm0,xmm1
		; XMM0 = 2Y_M[N] - Y_M[N-1] - 2r*Y_M[N] + r*Y_M+1[N]

		movups xmm1, [esi+4*ecx-4]
		movups xmm2, [ebp-16]
		mulps xmm1,xmm2
		addps xmm0,xmm1
		; XMM0 = 2Y_M[N] - Y_M[N-1] - 2r*Y_M[N] + r*Y_M+1[N] + r*Y_M-1[N]

		omin:
		movups [edi],xmm0
		dec ecx
		jnz petla

	pop esi
	pop edi
	pop ebx

	add esp,16
	pop ebp
	ret
_wave_calculate_next_step ENDP
end
