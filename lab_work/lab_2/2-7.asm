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
 ; AX = current UTF-16 character
    mov dl, al
    cmp dl, 'a'
    jb  check_pl
    cmp dl, 'z'
    ja  check_pl
    sub al, 20h
    mov ah, 0
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

cat1: mov ax,0104H
      jmp save
cat2: mov ax,0106H
      jmp save
cat3: mov ax,0118H
      jmp save
cat4: mov ax,0141H
      jmp save
cat5: mov ax,0143H
      jmp save
cat6: mov ax,00D3H
      jmp save
cat7: mov ax,015AH
      jmp save
cat8: mov ax,0179H
      jmp save
cat9: mov ax,017BH
      jmp save
go_on:
    movzx ax, dl
save:
    mov [storeW + ebx*2], ax  ; store UTF-16 character
    inc ebx                     
    dec ecx
    jnz ptl

; writing the fixed text
mov word ptr [storeW + ebx*2], 0
push 0 ; MB_OK

push OFFSET 0
push OFFSET storeW
push 0 ; NULL
call _MessageBoxW@16
 push 0 
 call _ExitProcess@4
_main ENDP
END
