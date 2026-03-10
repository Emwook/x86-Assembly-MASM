.686
.model flat
option casemap:none
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
    buffer db 16 dup(?)
    newline db 13,10

.code
write_EAX PROC
    pushad
    mov ecx, 0
    mov edi, OFFSET buffer + 15
    mov byte ptr [edi], 0

convert_loop:
    mov edx, 0
    mov ebx, 10
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx
    cmp eax, 0
    jnz convert_loop

    push ecx
    push edi
    push 1
    call __write
    add esp, 12

    push 2
    push OFFSET newline
    push 1
    call __write
    add esp, 12

    popad
    ret
write_EAX ENDP

write_nums PROC
    pusha
    mov edi, 1
    mov esi, 1
    mov ebx, 50
lp:
    mov eax, edi
    call write_EAX
    add edi, esi
    inc esi
    dec ebx
    jnz lp
    popa
    ret
write_nums ENDP
_main PROC
    call write_nums
    push 0
    call _ExitProcess@4
_main ENDP
END
