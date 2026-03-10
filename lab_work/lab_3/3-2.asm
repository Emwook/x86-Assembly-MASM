.686
.model flat
option casemap:none
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
   space db 12 dup (?)
   ten dd 10 ; mnożnik
   buffer db 16 dup(?)
   newline db 13,10


.code
    read_EAX PROC
        push dword PTR 12
        push dword PTR OFFSET space
        push dword PTR 0
        call __read

        mov eax, 0
        mov ebx, OFFSET space 
        get_chars:
            mov cl, [ebx]
            inc ebx
            cmp cl,10
            je was_enter

            sub cl, 30H 
            movzx ecx, cl 
            mul dword PTR ten
            add eax, ecx 

            jmp get_chars
        was_enter:
            ret
    read_EAX ENDP

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
_main PROC
    push ebx
    push ecx
    push edx
    push ebp
    push edi
    push esi
    call read_EAX
    pop esi
    pop edi
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pusha
    call write_EAX
    popa
    call _ExitProcess@4
_main ENDP
END
