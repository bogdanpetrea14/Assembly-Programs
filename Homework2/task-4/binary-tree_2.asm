extern array_idx_2      ;; int array_idx_2

section .text
    global inorder_intruders

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_intruders(struct node *node, struct node *parent, int *array)
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor care nu respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista
;
;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;
;        array  -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: DOAR in frunze pot aparea valori gresite!
;          vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!

; HINT: folositi variabila importata array_idx_2 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test al functiei inorder_intruders.      

inorder_intruders:
    enter 0, 0
    pusha
    push ebx
    push esi 
    push edi

    mov eax, [ebp + 8] ; current node
    mov ebx, [ebp + 12] ; parrent ul
    mov ecx, [ebp + 16] ; output

    cmp eax, 0
    je end

    ; subarborele stang
    mov edx, [eax + 4]
    push ecx
    push ebx
    push edx
    call inorder_intruders
    add esp, 12


    mov edx, [eax]       ; Get the value of the current node
    mov edi, array_idx_2 ; Get the index variable address
    mov esi, [edi]       ; Load the current index value
    mov [ecx + esi * 4], edx ; Store the value in the output array
    inc esi              ; Increment the index
    mov [edi], esi   

    


    ; subarborele drept
    mov edx, [eax + 8]
    push ecx
    push ebx
    push edx
    call inorder_intruders
    add esp, 12

end:
    pop edi
    pop esi 
    pop ebx
    popa
    leave
    ret


