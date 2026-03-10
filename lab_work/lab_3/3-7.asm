.686
.model flat
option casemap:none
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
    buffer db 16 dup(?)      ; temp text buffer
    newline db 13,10

.code
show_EAX PROC
    pushad
    mov ecx, 0
    mov edi, OFFSET buffer + 15
    mov byte ptr [edi], 0    ; optional terminator

convert_loop:
    mov edx, 0
    mov ebx, 10
    div ebx                  ; EAX / 10
    add dl, '0'              ; 0 in ascii to have a good char-code for the chars
    dec edi
    mov [edi], dl
    inc ecx
    cmp eax, 0
    jnz convert_loop

    ; write digits
    push ecx
    push edi
    push 1
    call __write
    add esp, 12

    ; newline
    push 2
    push OFFSET newline
    push 1
    call __write
    add esp, 12

    popad
    ret
show_EAX ENDP

show_numbers PROC
   pusha
    mov ecx, 0
    mov eax, 1
    mov edi, 0
    mov esi, 1
    mov ebx, 40
lp:
    mov ecx, edi
    add edi, eax
    mov eax, ecx
    call show_EAX       ; print as text
    dec ebx
    jnz lp
    popa
    ret
show_numbers ENDP
_main PROC
    call show_numbers
    push 0
    call _ExitProcess@4
_main ENDP
END
