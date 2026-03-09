.686
.model flat
extern _ExitProcess@4 : PROC
extern __write: PROC
public _main
.data
tekst db 10, 'Nazywam si',169,' Emilia', 10
db 'M',162,'j pierwszy 32-bitowy program '
db 'asemblerowy dzia',136,'a ju',190,' poprawnie!', 10

.code
_main PROC
; sum of 3 + 5 + 7 + 9 + 11
; with using a loop
mov ecx, 85 ; char count
push ecx
push dword PTR OFFSET tekst 
push dword PTR 1
call __write 
add esp, 12

push dword PTR 0 
call _ExitProcess@4
_main ENDP
END