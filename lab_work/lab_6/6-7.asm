.386
DATA_SEG SEGMENT use16
    sprite_data DB 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0 
                DB 0, 0, 0, 0, 0, 2, 15, 2, 14, 2, 2, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 2, 2, 2, 2, 6, 2, 0, 0, 0, 0, 0    
                DB 0, 0, 0, 0, 2, 2, 14, 2, 2, 2, 2, 5, 0, 0, 0, 0
                DB 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0
                DB 0, 0, 0, 0, 0, 2, 12, 2, 2, 12, 2, 0, 0, 0, 0, 0 
                DB 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0 
                DB 0, 0, 2, 2, 2, 2, 4, 2, 2, 2, 2, 12, 2, 2, 0, 0 
                DB 0, 2, 2, 2, 4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 
                DB 0, 0, 0, 0, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0
                DB 0, 0, 0, 0, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0
    
    offset_di dw 7398h
    
    current_x dw 152 
    velocity  dw 1
DATA_SEG ENDS

program SEGMENT use16
ASSUME cs:program, ds:DATA_SEG

obsluga_zegara PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push ds
    push es

    mov ax, DATA_SEG
    mov ds, ax
    
    mov ax, 0A000h
    mov es, ax

    call ERASE

    mov ax, velocity

    cmp current_x, 304
    jge odbij_w_lewo

    cmp current_x, 0
    jle odbij_w_prawo

    jmp wykonaj_ruch

odbij_w_lewo:
    mov velocity, -1 
    mov ax, -1
    jmp wykonaj_ruch

odbij_w_prawo:
    mov velocity, 1
    mov ax, 1

wykonaj_ruch:
    add current_x, ax
    add offset_di, ax 
    call DRAW

    pop es
    pop ds
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

    jmp dword PTR cs:wektor8

    wektor8 dd ? 
obsluga_zegara ENDP

DRAW PROC
    push ax
    push bx
    push si
    push di
    push cx 

    mov di, offset_di
    mov si, OFFSET sprite_data
    mov al, 16
    mov bx, 320-16

draw_loop:
    mov cx, 16
    rep movsb

    add di, bx
    dec al
    jnz draw_loop

    pop cx
    pop di
    pop si
    pop bx
    pop ax
    ret
DRAW ENDP

ERASE PROC
    push ax
    push bx
    push di
    push cx

    mov di, offset_di
    xor al, al
    mov bx, 320-16
    mov ah, 16

erase_loop:
    mov cx, 16
    rep stosb

    add di, bx
    dec ah
    jnz erase_loop

    pop cx
    pop di
    pop bx
    pop ax
    ret
ERASE ENDP

MAIN PROC
    push ds
    push es
    push ax

    mov ax, DATA_SEG
    mov ds, ax

    mov ax, 13h
    int 10h

    mov ax, 0A000h
    mov es, ax

    call DRAW

    mov ax, 351Ch
    int 21h
    mov word PTR cs:wektor8, bx
    mov word PTR cs:wektor8+2, es

    push ds
    mov dx, OFFSET obsluga_zegara
    push cs
    pop ds 
    mov ah, 25h
    mov al, 1ch
    int 21h
    pop ds

wait_loop:
    mov ah, 01h
    int 16h
    jz wait_loop

    mov ah, 00h
    int 16h

    push ds
    mov dx, word PTR cs:wektor8
    mov ds, word PTR cs:wektor8+2
    mov ah, 25h
    mov al, 1ch
    int 21h
    pop ds

    mov ax, 3h
    int 10h
    
    pop ax
    pop ds
    pop es

    mov ax, 4c00h
    int 21h
MAIN ENDP

program ENDS

s SEGMENT stack
db 256 dup (?)
s ENDS

END MAIN