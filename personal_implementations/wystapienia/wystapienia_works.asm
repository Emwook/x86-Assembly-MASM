.686
.model flat
extern _calloc:proc
public _wystapienia

.code
_wystapienia proc
    push ebp
    mov ebp, esp
    sub esp, 4

    push ebx
    push edi
    push esi

    mov eax, [ebp+12]
    mov ebx, 5
    push ebx
    push eax
    call _calloc
    add esp,8
    mov [ebp-4], eax

    mov eax, [ebp+12]
    xor edx,edx
    mov ecx, 5
    mul ecx
    add eax,[ebp-4]
    mov edx,eax
    push edx

    xor ecx,ecx
    xor edx,edx
    mov edi, [ebp+12]
    petla:
        mov ebx, [ebp+8]
        add ebx, ecx
        xor ax,ax
        mov al, byte ptr [ebx]

        push eax

        mov bx,di
        div bl
        movzx edx,ah

        pop eax
        
        mov esi, [ebp-4]
        lea ebx, [edx + 4*edx]
        add esi, ebx

        cmp byte ptr [esi], al
        je zapisz
        cmp byte ptr [esi+1], 0
        je zapisz

        szukamy_miejsca:
            add esi,5
            pop edx
            cmp esi,edx
            push edx
            jl sprawdzam_miejsce

            mov esi,[ebp-4]

            sprawdzam_miejsce:
            cmp byte ptr [esi+1],0
            je zapisz
            cmp byte ptr [esi],al
            je zapisz

            jmp szukamy_miejsca

        zapisz:
        mov byte ptr [esi],al
        add esi,1
        inc dword ptr [esi]
        mov eax, [ebp+12]
        dec eax
        cmp ecx, eax
        jae koniec
        inc ecx
        jmp petla

    koniec:
    mov eax, [ebp-4]
    mov [ebp+8], eax

    pop edx
    pop esi
    pop edi
    pop ebx

    add esp, 4
    pop ebp
    ret
_wystapienia endp
end