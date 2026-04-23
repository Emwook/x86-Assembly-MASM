.model flat
public _srednia_harm

.code
_srednia_harm PROC
    push ebp
    mov  ebp, esp

    mov  ecx, [ebp+12]    ; ecx = n
    mov  edx, [ebp+8]     ; edx = tablica

    fldz                  ; ST(0) = 0.0 (nasz akumulator sumy)

sum_loop:
    cmp  ecx, 0
    je   compute_result

    ; Obliczanie 1 / x
    fld1                  ; ST(0) = 1.0, ST(1) = suma
    fild dword ptr [edx]  ; ST(0) = x, ST(1) = 1.0, ST(2) = suma
    fdivp st(1), st(0)    ; ST(0) = 1.0 / x, ST(1) = suma
    
    ; --- KLUCZOWA POPRAWKA ---
    faddp st(1), st(0)    ; Dodaj (1/x) do sumy i zdejmij (1/x) ze stosu
                          ; Teraz ST(0) to zaktualizowana suma

    add  edx, 4
    dec  ecx
    jmp  sum_loop

compute_result:
    ; W tym momencie ST(0) zawiera sumę odwrotności (0.4 dla dwóch piątek)
    
    mov  eax, [ebp+12]
    push eax
    fild dword ptr [esp]  ; ST(0) = n, ST(1) = suma_odwrotnosci
    add  esp, 4

    ; Obliczanie n / suma
    ; Używamy fdivrp, aby podzielić ST(0) przez ST(1), zapisać wynik w ST(1) i zdjąć ST(0)
    ; Działanie: Dest = Source / Dest  ->  ST(1) = ST(0) / ST(1)
    fdivrp st(1), st(0)   ; Wynik zostaje w ST(0)

    pop  ebp
    ret
_srednia_harm ENDP

END