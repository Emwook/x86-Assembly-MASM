.686
.model flat
extern _calloc:proc
public _wystapienia

.code
_wystapienia proc
    push ebp
    mov ebp, esp
    sub esp, 4

    push ebx
    push edi
    push esi

    push 5
    push 256
    call _calloc
    add esp, 8

    mov [ebp-4], eax
    
    xor ecx, ecx
    xor esi, esi

    petla_zewn:
        mov ebx, [ebp+8] 
        mov al, byte ptr [ebx+ecx]
        
        xor edx, edx

        petla_wewn:
            cmp edx, esi
            je nowy_znak

            mov edi, [ebp-4]
            lea ebx, [edx + 4*edx]
            add edi, ebx

            cmp byte ptr [edi], al 
            je superancko
            
            jmp dalej_krecimy

            nowy_znak:
                mov edi, [ebp-4]
                lea ebx, [esi + 4*esi]
                add edi, ebx
                
                mov byte ptr [edi], al  
                mov dword ptr [edi+1], 1  

                inc esi 
                jmp zacnie

            superancko:
                inc dword ptr [edi+1]

            zacnie:
                inc ecx
                cmp ecx, [ebp+12]
                jb petla_zewn
                jmp koniec

            dalej_krecimy:
                inc edx
                jmp petla_wewn

    koniec:
        mov eax, [ebp-4]

    pop esi
    pop edi
    pop ebx

    add esp, 4
    pop ebp
    ret
_wystapienia endp
end