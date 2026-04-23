public suma_siedmiu_liczb
.code
	suma_siedmiu_liczb PROC

		; liczby dostane przez rcx, rdx, r8, r9, [rbp+40], [rbp+48], [rbp+56]
		; w [rsp + 32] mamy adres powrotu - slad

		mov rax, rcx
		add rax, rdx
		add rax, r8
		add rax, r9
		add rax, [rsp + 40]
		add rax, [rsp + 48]
		add rax, [rsp + 56]

		ret
	suma_siedmiu_liczb ENDP
END
