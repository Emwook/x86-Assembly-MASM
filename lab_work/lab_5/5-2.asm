.model flat
public _nowy_exp

.code
_nowy_exp PROC
    push ebp
    mov  ebp, esp
    mov ebx, 1
    mov ecx,20
    
    fld dword ptr [ebp+8]  ; ST(0) = x
    
    fld1                   ; ST(0) = 1.0 (suma), ST(1) = x
    fld1                   ; ST(0) = 1.0 (wyraz), ST(1) = 1.0 (suma), ST(2) = x

start_petli:
dec ecx
    fmul st(0), st(2)      ; wyraz * x
    
    push ebx
    fidiv dword ptr [esp]  ; wyraz / i
    add esp, 4

    fadd st(1), st(0)      ; suma += wyraz

    inc ebx
    loop start_petli

    fstp st(0)
    fxch st(1)
    fstp st(0)

    pop  ebp
    ret
_nowy_exp ENDP

END