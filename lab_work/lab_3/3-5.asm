.686
.model flat
option casemap:none
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
   buffer db 12 dup (?)
   ten dd 10 ; multiplier
   decoder db '0123456789ABCDEF '


.code
    read_EAX PROC
        push ebx
        push ecx
        push edx
        push ebp
        push edi
        push esi
        push dword PTR 12
        push dword PTR OFFSET buffer
        push dword PTR 0
        call __read

        add esp, 12 

        mov eax, 0
        mov ebx, OFFSET buffer
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
            pop esi
            pop edi
            pop ebp
            pop edx
            pop ecx
            pop ebx
            ret
    read_EAX ENDP

    write_EAX_hex PROC
        pusha 
        mov edx,0
        sub esp, 12
        mov edi, esp 
        
        mov ecx, 8 
        mov esi, 1
        mov ebp, 0

            loop3hex:
                rol eax, 4
                mov ebx, eax
                and ebx, 0000000FH

                cmp ebx, 0
                jne not_zero

                ; if zero:
                cmp ebp, 0
                je starting_zeros
                mov dl, decoder[0]
                jmp continue

            starting_zeros:
                mov dl,decoder[16] 
                jmp continue

            not_zero:
                mov dl, decoder[ebx]
                mov ebp, 1

            continue:
                mov [edi][esi], dl
                inc esi
                loop loop3hex


        mov byte PTR [edi][0], 10
        mov byte PTR [edi][9], 10
        push 10
        push edi
        push 1 
        call __write
        add esp, 24

        popa 
        ret 
    write_EAX_hex ENDP

    
_main PROC

    call read_EAX
    call write_EAX_hex
    call _ExitProcess@4
_main ENDP
END
