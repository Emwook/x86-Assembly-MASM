.686
.model flat

extern _MessageBeep@4:PROC
extern _Sleep@4:PROC
extern _GetLocalTime@4:PROC
extern _write:PROC
extern _malloc:PROC
extern _free:PROC

public _beeper

.data
format db "%d",0
beep db "beep "
boop db "boop "

.code
_beeper PROC
    push ebp
    mov ebp,esp
    sub esp,4

    push edx
    push ebx

    push dword ptr [ebp+8]
    call _MessageBeep@4

    push 5
    mov eax, [ebp+8]
 
    cmp eax,20
    jz zero
    cmp eax,30
    jz zero
    jmp nonzero

    zero:
        push offset boop
        jmp continue

    nonzero:
        push offset beep
        jmp continue

    continue:
    push 1
    call _write
    add esp, 12

    push 10
    call _malloc
    add esp,4

    mov [ebp-4],eax
    mov ebx, [ebp-4]
    
    mov byte ptr [ebx], 'b'
    mov byte ptr [ebx+1], 'o'
    mov byte ptr [ebx+2], 'o'
    mov byte ptr [ebx+3], 'p'
    mov byte ptr [ebx+4], ' '

    push 5
    push ebx
    push 1
    call _write
    add esp,12

    push dword ptr [ebp-4]
    call _free
    add esp,4

    push 1250
    call _Sleep@4

    pop ebx
    pop edx
    add esp,4
    pop ebp
    ret 
_beeper ENDP
END