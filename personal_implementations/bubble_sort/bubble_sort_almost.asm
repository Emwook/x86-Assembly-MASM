.686
.model flat
extern _calloc:proc
extern _wystapienia:proc
public _sortuj
.code
_sortuj proc
    push ebp
    mov ebp, esp
    sub esp, 4

    push ebx
    push edi
    push esi

    petla:
        xor edx,edx
        xor ecx,ecx
        petla_wewn:
            lea edi,[ecx+4*ecx+1]
            add edi, [ebp+8]
            mov esi, edi
            add esi,5
            mov ebx, [esi]
            cmp esi,0
            je stop
            cmp dword ptr [edi],ebx
            jb swap
            after_swap:
            cmp ecx, [ebp+12]
            jae stop
            inc ecx
            jmp petla_wewn

        swap:
            mov ebx, dword ptr [edi]
            mov eax, dword ptr [esi]
            
            mov dword ptr [edi], eax
            mov dword ptr [esi], ebx

            dec esi
            dec edi
            mov bl, byte ptr [esi]
            xchg byte ptr [edi], bl
            mov byte ptr [esi], bl

            mov edx,1

            jmp after_swap

        stop:
            cmp edx,1
            je petla

        
            ;idziemy po kazdym wyrazie, zamieniamy te dwa sasiadujace, gdzie pierwszy jest mniejszy niz drugi
            ;ustawiamy flage gdy nastapila zamiana
            ;jesli flaga to jeden to probujemy od poczatku


    pop esi
    pop edi
    pop ebx

    add esp, 4
    pop ebp
    ret
_sortuj endp
end