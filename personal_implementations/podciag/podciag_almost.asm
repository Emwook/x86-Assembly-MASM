.686
.model flat
;extern _calloc:proc
;extern _wystapienia:proc
public _podciag

.code
_podciag proc
    push ebp
    mov ebp, esp
    sub esp, 24

    push ebx
    push edi
    push esi
    

    mov eax,1
    mov dword ptr [ebp-4],eax
    
    xor eax,eax
    mov ebx, dword ptr [ebp+8]
    mov dword ptr [ebp-8], ebx
    mov dword ptr [ebp-12],eax
    mov dword ptr [ebp-16],eax
    mov dword ptr [ebp-20],eax

    xor ebx,ebx
    cld
    mov edi,[ebp+8]
    mov ecx,0FFFFFFFFH
    repne scasd
    neg ecx
    sub ecx,2
    mov dword ptr [ebp-20],ecx

    petla:
        cld
        mov ecx,[ebp-20]
        mov edi,[ebp+8]
        mov esi,[ebp+12]

        mov eax,[ebp-12]

        cmp eax, dword ptr [ebp-20]
        ja koniec

        xor edx,edx
        mov ebx,4
        mul ebx

        add edi,eax

        mov ebx,0
        cmp dword ptr [edi], ebx
        mov ebx,4

        mov eax,[ebp-16]
        
        cmp eax, dword ptr [ebp-20]
        jbe next

        xor edx,edx
        mul ebx


        add esi,eax

        mov ebx,0
        cmp dword ptr [esi], ebx
        je next

        repe cmpsd
        mov ebx, [ebp-20]
        sub ebx, ecx
        mov ecx, ebx

        cmp ecx,dword ptr [ebp-4]
        jbe restart
        
        mov edx, [ebp-12]
        shl edx,2
        add edx, [ebp-8]
        mov dword ptr [ebp-4],ecx
        mov dword ptr [ebp-8],edx

        restart:
            inc dword ptr [ebp-16]
            jmp petla

        next:
            mov ebx,0
            mov dword ptr [ebp-16],ebx
            inc dword ptr [ebp-12]
            jmp petla

    koniec:
    mov ebx,1
    cmp dword ptr [ebp-4],ebx
    ja zeruj
    mov eax, dword ptr [ebp-4]
   ; mov ebx, dword ptr [ebp-20]
    ;sub ebx, eax
    ;dec ebx
    ;mov eax, ebx
    mov ebx, 4
    xor edx,edx
    mul ebx
    add eax, dword ptr [ebp-8]
    mov dword ptr [ebp-4], eax
    jmp zakoncz

    zeruj:
    mov ebx,0
    mov dword ptr [ebp-4], ebx
    
    zakoncz:
    mov eax, dword ptr [ebp-4]
    pop esi
    pop edi
    pop ebx

    add esp, 24
    pop ebp
    ret
_podciag endp
end