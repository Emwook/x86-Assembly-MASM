.686
.model flat
option casemap:none
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
   store db 12 dup (?)
   tenner dd 10 ; multiplier
   decoder db '0123456789ABCDEF '
   newline db 13,10         ; "\r\n"


.code
   read_to_EAX_hex PROC
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
      
        sub esp, 12
        mov esi, esp
        push dword PTR 10
        push esi
        push dword PTR 0
        call __read

        add esp, 1
        mov eax, 0
        starter:
        mov dl, [esi]
        inc esi
        cmp dl, 10 ; check for 'enter'
        je readt
        ; check if char is one of 0, 1, 2 , ..., 9
        cmp dl, '0'
        jb starter
        cmp dl, '9'
        ja check
        sub dl, '0' ; ASCII to value
        writeto:
        shl eax, 4
        or al, dl 
        jmp starter

       	check:
        cmp dl, 'A'
        jb starter 
        cmp dl, 'F'
        ja check_again
        sub dl, 'A' - 10 
        jmp writeto

        check_again:
        cmp dl, 'a'
        jb starter 
        cmp dl, 'f'
        ja starter
        sub dl, 'a' - 10
        jmp writeto
        ready:

        add esp, 12
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
    read_to_EAX_hex ENDP
    show_eax PROC
        pushad
        mov ecx, 0
        mov edi, OFFSET store + 15
        mov byte ptr [edi], 0    ; optional terminator

    convert_loop:
        mov edx, 0
        mov ebx, 10
        div ebx                  ; EAX / 10
        add dl, '0'              
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
    show_eax ENDP


    
_main PROC

    call read_to_EAX_hex
    call show_eax       ; print as text
    call _ExitProcess@4
_main ENDP
END
