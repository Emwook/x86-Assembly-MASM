.686
.model flat
;extern _calloc:proc
;extern _wystapienia:proc
public _liczba_pi

.code
_liczba_pi proc
    push ebp
    mov ebp, esp
    sub esp, 24

    push ebx
    push edi
    push esi

    mov dword ptr [ebp-12],2

    finit
    fild dword ptr [ebp-12]
    xor ecx,ecx
    inc ecx

    petla:
        cmp ecx, dword ptr [ebp+8]
        jae koniec

        mov dword ptr [ebp-8],ecx
        mov dword ptr [ebp-24],0
        mov dword ptr [ebp-20],0
        mov dword ptr [ebp-16],0
        fild dword ptr [ebp-8]
        fild dword ptr [ebp-12]
        fild dword ptr [ebp-8]
        fprem
        fxch
        fistp dword ptr [ebp-24]
        faddp
        
        fild dword ptr [ebp-8]
        mov ebx,1
        mov dword ptr [ebp-20],ebx
        fild dword ptr [ebp-20]
        fild dword ptr [ebp-8]
        faddp
        fild dword ptr [ebp-12]
        fxch
        fprem
        fxch
        fistp dword ptr [ebp-16]
        faddp

        fdivp
        fmulp

        inc ecx
        jmp petla


    koniec:
    pop esi
    pop edi
    pop ebx

    add esp, 24
    pop ebp
    ret
_liczba_pi endp
end