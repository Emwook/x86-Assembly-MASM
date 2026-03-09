.686
.model flat
extern _MessageBoxW@16 : PROC
extern _ExitProcess@4 : PROC
extern __write : PROC 
extern __read : PROC 
public _main
.data
text_start db 10, 'Prosz',169,' napisa',134 ,' jaki',152,' tekst '
db 'i nacisn',165,134,' Enter', 10
text_end db ?
store db 80 dup (?)
storeW dw 80 dup (?)
new_line db 10
char_amount dd ?
.code
_main PROC


 mov ecx,(OFFSET text_end) - (OFFSET text_start)
 push ecx
 push OFFSET text_start
 push 1 ; device number
 call __write
 add esp, 12 ; clearing the stack

 push 80 ; char count
 push OFFSET store
 push 0 ;  device number
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; clearing the stack

 mov char_amount, eax
 mov ecx, eax ; ecx is a loop max value for iterator
 mov ebx, 0 ; ebx is a loop iterator here
 ptl: mov al, store[ebx] 
 cmp dl, 'a'
 jb  check_pl
 cmp dl, 'z'
 ja  check_pl
 sub dl, 20H
 jmp save

 ;polish extended latin chars
 check_pl:
 cmp dl, 165
 je cat1
 cmp dl, 134
 je cat2 
 cmp dl, 169
 je cat3 
 cmp dl, 136
 je cat4 
 cmp dl, 228
 je cat5 
 cmp dl, 162
 je cat6 
 cmp dl, 152
 je cat7
 cmp dl, 171
 je cat8
 cmp dl, 190
 je cat9 
 jmp go_on

cat0: sub dl,20
      jmp zapisz
cat1: sub dl,1
      jmp zapisz
cat2: add dl,9
      jmp zapisz
cat3: add dl,21
      jmp zapisz
cat4: add dl,62
      jmp zapisz
cat5: sub dl,30
      jmp zapisz
go_on:
save:
    mov store[ebx], dl
    inc ebx
    loop ptl

 push char_count
 push OFFSET store
 push 1
 call __write
 add esp, 12
 push 0
 call _ExitProcess@4
_main ENDP
END