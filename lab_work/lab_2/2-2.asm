.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main

.data
title dw 'T','e','k','s','t',' ','w',' '
dw 'f','o','r','m','a','c','i','e',' '
dw 'U','T','F','-','1','6', 0
text_unicode dw 'K','a',017CH,'d','y',' ','z','n','a','k',' '
dw 'z','a','j','m','u','j','e',' '
dw '1','6',' ','b','i','t',00F3H,'w', 0
title_Win1250 db 'Tekst w standardzie Windows 1250', 0
text_Win1250 db 'Każdy znak zajmuje 8 bitów', 0

.code
_main PROC
 push 0 ; stała MB_OK
; adres obszaru zawierającego tytuł
 push OFFSET title_Win1250
; adres obszaru zawierającego tekst
 push OFFSET text_Win1250
 push 0 ; NULL
 call _MessageBoxA@16

 push 0 ; stala MB_OK
 push OFFSET title_unicode
 push OFFSET text_unicode
 push 0 ; NULL
 call _MessageBoxW@16
 push 0
 call _ExitProcess@4
_main ENDP
END