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
DATA_SEG ENDS

program SEGMENT use16
ASSUME cs:program, ds:DATA_SEG

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

game_loop:
    mov ah, 00h
    int 16h

    cmp al, 1Bh
    je exit_program

    push ax
    call ERASE
    pop ax

    cmp al, 'w'
    je move_up
    
    cmp al, 's'
    je move_down

    cmp al, 'a'
    je move_left

    cmp al, 'd'
    je move_right

    jmp redraw

move_up:
    sub offset_di, 320
    jmp redraw

move_down:
    add offset_di, 320
    jmp redraw

move_left:
    dec offset_di
    jmp redraw

move_right:
    inc offset_di
    jmp redraw

redraw:
    call DRAW
    jmp game_loop

exit_program:
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