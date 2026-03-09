.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
text_unicode dw 'T','o',' ','j','e','s','t',' '
dw 'p','i','e','s',' ',0D83DH,0DC15H,' ','a',' ','t','o',' '
dw 'k','o','t',0D83DH,0DC08H, 0
title_unicode dw 'z','n','a','k','i',0

.code
_main PROC
 push 0 ; MB_OK
 push OFFSET title_unicode
 push OFFSET text_unicode
 push 0
 call _MessageBoxW@16
 push 0 
 call _ExitProcess@4
_main ENDP
END