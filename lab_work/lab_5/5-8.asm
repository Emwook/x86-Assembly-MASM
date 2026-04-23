.686
.model flat
.XMM
public _kolo

.code
    _kolo PROC
        push ebp
        mov  ebp, esp

        fldpi ; 0)pi 
        fld dword ptr [ebp+8] ; 0)r, 1)pi
        fmul st(0),st(0)  ; 0)r*r 1) pi
        fmulp st(1),st(0) ; 0) r*r*pi

        mov eax, [ebp+12] ; adres w eax to "pole"
        fstp dword ptr [eax] ; st puste, "pole" = r*r*pi

        fldpi ;0)pi 
        fadd st(0), st(0) ; 0)pi + pi = 2pi
    
        fld dword ptr [ebp+8] ; 0)r 1)pi + pi = 2pi
        fmulp ; st(1), st(0) 0) 2pi*r

        mov eax, [ebp+16] ; adres w eax to "dlugosc"
        fstp dword ptr [eax] ; st puste, "dlugosc" = r*r*pi

        pop ebp
        ret
    _kolo ENDP
END