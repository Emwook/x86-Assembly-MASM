.686
.model flat
extern _ExitProcess@4:PROC
public SUMA

.code
SUMA PROC PASCAL arg1:DWORD, arg2:DWORD, arg3:DWORD 
    push edi
    push esi
    push ecx
    push ebx
    ; (A+B)*C
    mov edi, arg3 ;c
    mov esi, arg2 ;b
    mov edx, arg1 ;a

    add esi,edx
    mov eax,esi
    mul edi

    pop ebx
    pop ecx
    pop esi
    pop edi

    ret 
SUMA ENDP
END