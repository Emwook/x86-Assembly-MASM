.686
.model flat
;extern _calloc:proc
;extern _wystapienia:proc
public _check_data

.code
_check_data proc
    push ebp
    mov ebp, esp
    sub esp, 80

    push ebx
    push edi
    push esi

    xor ecx,ecx
    mov edi, [ebp+8]
    add edi, ecx
    mov eax, dword ptr 0
    repne scasw
    dec ecx
    neg ecx
    inc ecx ;ecx to dlugosc slowa w u2

    mov eax, 2CH
    mov edx, ecx
    mov dword ptr [ebp-8], edx
    mov ecx, [ebp+8]
    add ecx,edx
    mov word ptr [ecx], ax

    lea edi, [ebp-52]
    mov eax,0
    mov ecx,10
    rep stosd

    xor edx,edx
    petla_slowo:
        xor ecx,ecx
        mov edi, [ebp+8]
        add edi, ecx
        mov eax, 2CH
        repne scasw
        dec ecx
        neg ecx
        inc ecx ;ecx to dlugosc slowa w u2

        sprawdz_pierwsza:
            mov edi, [ebp+8]
            add edi, edx
            cmp word ptr [edi],0
            je sprawdz

            mov edi, [ebp+8]
            movzx eax, word ptr [edi + 2*edx] ; Czytamy PIERWSZĄ cyfrę liczby (pod edx)
            sub eax, 30H

            cmp eax,10
            jae nastepne

            lea ebx, [ebp-52]
            inc dword ptr [ebx+4*eax]

            nastepne:
            inc ecx
            add edx,ecx
            jmp petla_slowo
            
    sprawdz:
    mov ecx, dword ptr [ebp-8]
    finit
    sprawdz_rozklad:
        
        lea eax, [ebp + 4*ecx -52] ;whole string length
        mov ebx ,[eax]
        mov dword ptr [ebp-4], ebx
        fild dword ptr [ebp-8] ;max_count
        fild dword ptr [ebp-4] ;num_count
        fdivp 

        fild dword ptr [ebp-4] ;num_count
        fld1
        fdivp
        fld1
        faddp
        fld1
        fyl2x
        fstp st(0)
        fldl2t
        fxch
        fdivp
        fsubp
        fabs

        mov dword ptr [ebp-4],8
        fild dword ptr [ebp-8]
        fld1
        fxch
        fdivp

        fsubp
        fldz
        fcomip st(0), st(1)
        fstp st(0)
        jl falsz

        dec ecx
        jnz sprawdz_rozklad
        jmp prawda
        
    falsz:
    mov eax, 1
    jmp koniec

    prawda:
    mov eax,0

    koniec:
    pop esi
    pop edi
    pop ebx

    add esp, 80
    pop ebp
    ret
_check_data endp
end