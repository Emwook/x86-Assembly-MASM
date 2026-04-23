.686
.XMM
.model flat
public _pm_jeden

.data
    tab REAL4 4 DUP (1.0)

.code
_pm_jeden PROC
    push ebp
    mov ebp, esp
    push esi

    mov esi, [ebp+8]

    movups xmm5, [esi]

    movups xmm0, tab

    addsubps xmm5, xmm0

    movups [esi], xmm5

    pop esi
    pop ebp
    ret
_pm_jeden ENDP
END