.686
.model flat
public _czy_pierwsza
.code

_czy_pierwsza PROC
    push ebp
    mov  ebp, esp

    push ebx
    push ecx
    push edx

    mov  ebx, [ebp+8]

    cmp  ebx, 2
    jl nie_pierwsza
    je pierwsza
    jg dalej

    dalej:
        mov ecx,2
        jmp dzielenie

dzielenie:
    mov  edx, 0
    mov  eax, ebx
    div  ecx
    cmp  edx, 0
    je   nie_pierwsza
    cmp ecx,2
    je dodaj_1
    jne dodaj_2

dodaj_2:
    add  ecx, 2
    jmp powrot_dzielenie

dodaj_1:
    inc ecx
    jmp ptl

ptl:
    mov  edx, ecx
    imul edx, ecx         ; EDX = i * i
    cmp  edx, ebx
    jg   pierwsza            ; jeśli i*i > n → liczba pierwsza

    jmp dzielenie
    powrot_dzielenie:
    jmp  ptl

pierwsza:
    mov  eax, 1
    jmp  koniec

nie_pierwsza:
    mov  eax, 0

koniec:
    pop  edx
    pop  ecx
    pop  ebx
    pop  ebp
    ret
_czy_pierwsza ENDP
END
