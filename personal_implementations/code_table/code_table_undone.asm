.686
.model flat
;extern _calloc:proc
;extern _wystapienia:proc
public _wypelnijtablicekodowa

.data
tablica_kodowa dd ?
liczba_wierszy dd 0

.code
_wypelnijtablicekodowa proc
    push ebp
    mov ebp, esp
    sub esp, 80

    push ebx
    push edi
    push esi

    outer:
        xor esi,esi
        xor edi,edi
        xor edx,edx
        xor edi,edi
        mov eax, [ebp+8] ; mamy tu adres pierwszego badanego wezla
        mov dword ptr [ebp-4], 0
        mov dword ptr [ebp-24],0
        mov [ebp-20], eax
        mov [ebp-8], eax
            process_cell:
                mov eax, [ebp-8]
                mov ebx,-1
                cmp edi,1
                ja go_one_higher

                cmp dword ptr [eax],bl
                je manage_leaf

                jmp go_one_deeper

                manage_leaf:
                    lea ebx, [tablica_kodowa + 2*esi]
                    add ebx, esi
                    push esi
                    mov esi, [ebp-4]
                    shl byte ptr [esi], 1
                    add byte ptr [esi], edi
                    xor edx,edx
                    mov dl, byte ptr [esi] ;kod naszego znaku
                    pop esi
                    
                    mov byte ptr [ebx+1],dl ; kod umieszczony

                    mov eax, [ebp-20]
                    add eax, 2
                    mov dl, byte ptr [eax]
                    mov byte ptr [ebx], dl ; znak ascii umeiszczony

                    mov dl,byte ptr [ebp-16] ; aktualny poziom zagniezdzenia - 0 to korzen
                    dec dl
                    mov byte ptr [ebx], dl ; dlugosc kodu umieszczona

                    inc dword ptr [ebp-12]

                    inc edi
                    inc ecx
                    jmp go_one_higher

            go_one_higher:
                cmp dword ptr [ebp-16],0
                je koniec

                dec dword ptr [ebp-16]
                shr dword ptr [ebp-4]

                mov eax, [ebp-16]
                xor edx,edx
                mul dword ptr 4
                xor edx,edx
                lea edx, [ebp-20]
                sub edx,eax
                mov dword ptr [ebp-8], edx
         
                jmp process_cell

            go_one_deeper:
                
                inc dword ptr [ebp-16]

                mov eax, dword ptr [ebp-8]
                mov ebx, [eax]
                add ebx,4
                mov dword ptr [eax], ebx
                mov dword ptr [ebp-8], eax

                mov ebx, [ebp-16]
                xor edx,edx
                mul dword ptr 4
                xor edx,edx
                lea edx, [ebp-20]
                sub edx,ebx
                mov dword ptr [edx], eax 


    pop esi
    pop edi
    pop ebx

    add esp, 80
    pop ebp
    ret
_wypelnijtablicekodowa endp
end