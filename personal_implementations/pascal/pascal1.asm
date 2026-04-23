.686
.model flat
extern SUMA:PROC
extern _ExitProcess@4:PROC
extern __write:PROC

.data
    bufor db 2 dup(?) ; Rezerwujemy 1 bajt na znak ASCII

.code
_main PROC
	push 4 ;A
	push 5 ;B
	push 5 ;C
	call SUMA

	mov ebx,10
	div ebx
	add al, 48  
	add dl,48
	mov [bufor+1],dl
	mov [bufor], al
	push 2
	push offset bufor
	push 1
	call __write
	add esp,12

	push 0
	call _ExitProcess@4
_main ENDP
END