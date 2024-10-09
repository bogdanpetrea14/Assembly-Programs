extern array_idx_1      ;; int array_idx_1

section .text
    global inorder_parc

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_parc(struct node *node, int *array);
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor in vectorul array.
;    @params:
;        node  -> nodul actual din arborele de cautare;
;        array -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!
; HINT: folositi variabila importata array_idx_1 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test.

inorder_parc:
    enter 0, 0
    pusha
    push ebx
    push esi
    push edi
    
    mov eax, [ebp + 8] ; tree-ul
    mov ebx, [ebp + 12] ; output ul

    cmp eax, 0
    je end

    mov ecx, [eax + 4]
    push ebx
    push ecx
    call inorder_parc
    add esp, 8


    mov edx, [eax]       ; Get the value of the current node
    mov edi, array_idx_1 ; Get the index variable address
    mov esi, [edi]       ; Load the current index value
    mov [ebx + esi * 4], edx ; Store the value in the output array
    inc esi              ; Increment the index
    mov [edi], esi       ; Update the index variable


    mov ecx, [eax + 8]
    push ebx
    push ecx
    call inorder_parc
    add esp, 8

end:  
    pop edi
    pop esi
    pop ebx
    popa
    leave
    ret
