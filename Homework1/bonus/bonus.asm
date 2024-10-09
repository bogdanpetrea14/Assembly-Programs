%include "../include/io.mac"

section .data
    var DB 0
section .text
    global bonus
    extern printf
bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board
    ; ebp  + 16 primu nr, apoi + 20 al doilea
    ; [ecx] = pr numar [ecx + 4] al doilea numar
    ; pentru fiecare 1, pui intr un registru si faci shiftare la stanga cu cate 0 uri sunt

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    cmp eax, 0
    je prima_linie

    cmp eax, 7
    je ultima_linie

    cmp ebx, 0
    je prima_coloana

    cmp ebx, 7
    je ultima_coloana

ultima_coloana:
    cmp eax, 3
    jl c7p

    cmp eax, 4
    jg c7s

c7p:
    xor edx, edx
    add [ecx], edx
    add edx, 65537
    push ecx
    
    xor ecx, ecx
    add cl, 6
    push eax
    dec eax
    times 3 add eax, eax
    add cl, al
    shl edx, cl

    pop eax
    pop ecx
    add [ecx + 4], edx
    jmp end

c7s:
    xor edx, edx
    add [ecx + 4], edx
    add edx, 65537
    push ecx
    
    xor ecx, ecx
    add cl, 6
    push eax
    dec eax
    sub eax, 4
    times 3 add eax, eax
    add cl, al
    shl edx, cl

    pop eax
    pop ecx
    add [ecx], edx
    jmp end

prima_coloana:
    cmp eax, 3
    jl c5p

    cmp eax, 4
    jg c5s

c5p:
    xor edx, edx
    add [ecx], edx
    add edx, 65537
    push ecx
    
    xor ecx, ecx
    add cl, 1
    push eax
    dec eax
    times 3 add eax, eax
    add cl, al
    shl edx, cl

    pop eax
    pop ecx
    add [ecx + 4], edx
    jmp end


c5s:
    xor edx, edx
    add [ecx + 4], edx
    add edx, 65537
    push ecx
    
    xor ecx, ecx
    add cl, 1
    push eax
    dec eax
    sub eax, 4
    times 3 add eax, eax
    add cl, al
    shl edx, cl

    pop eax
    pop ecx
    add [ecx], edx
    jmp end

prima_linie:
    cmp ebx, 0
    je c1

    cmp ebx, 7
    je c2

    jmp c6

ultima_linie:
    cmp ebx, 0
    je c3

    cmp ebx, 7
    je c4

    jmp c7

c1:
    xor edx, edx
    add [ecx], edx
    add edx, 1
    shl edx, 9
    add [ecx + 4], edx
    jmp end

c2:
    xor edx, edx
    add [ecx], edx
    add edx, 1
    shl edx, 14
    add [ecx + 4], edx
    jmp end

c3:
    xor edx, edx
    add [ecx + 4], edx
    add edx, 1
    shl edx, 17
    add [ecx], edx
    jmp end

c4:
    xor edx, edx
    add [ecx + 4], edx
    add edx, 1
    shl edx, 22
    add [ecx], edx
    jmp end

c5:

c6:
    xor edx, edx
    add [ecx], edx
    
    push ebx
    push ecx
    
    mov cl, bl
    xor ebx, ebx
    mov ebx, 5
    add cl, 7
    shl ebx, cl

    xor ecx, ecx
    pop ecx
    add [ecx + 4], ebx
    pop ebx
    jmp end

c7:
    
    xor edx, edx
    add [ecx + 4], edx

    push ebx
    push ecx

    mov cl, bl
    add cl, 15

    xor ebx, ebx
    add ebx, 5

    shl ebx, cl

    xor ecx, ecx
    pop ecx
    add [ecx], ebx
    pop ebx
    jmp end




end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


; La fel ca in cazul task-ului 4, se vor pune 1-uri pe mai multe pozitii 
; (In aceasta implementare, sunt luate doar cazurile cand se adauga maxim 
; 2 de 1, lipsind practic zonele de mijloc). Pentru a adauga 1 pe o 
; singura pozitie, adica in cazul colturilor, se adau acest 1 pe prima 
; pozitie, dupa care se shifteaza de cate ori este nevoie pentru a fi 
; dus pe pozitia dorita. Ulterior, se muta acest numar in [ecx], 
; respectiv [ecx + 4].
; Pentru prima, respectiv ultima linie, se observa in in binar, 
; 5 este 101. Daca il adaugam in matrice initial, vom avea o matrice 
; de genul (adica mutam 5-ul in [ecx + 4]):

; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0        
; 0 0 0 0 0 0 0 0        
; 0 0 0 0 0 0 0 0
; - - - - - - - -
; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; 1 0 1 0 0 0 0 0

; Acest 5 va fi shiftat de cate ori este nevoie pentru a fi
;  dus in pozitia de care este nevoie.

; Pentru lateralele tablei, vom incerca sa formam tot 101, 
; doar ca pe verticala. Luand in considerare enuntul si modul 
; in care se trimite numarul care va forma matriceai, vom adauga in 
; registru 65537, care pe matrice va fi:

; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; - - - - - - - -
; 0 0 0 0 0 0 0 0
; 1 0 0 0 0 0 0 0
; 0 0 0 0 0 0 0 0
; 1 0 0 0 0 0 0 0

; Astfel, mutam strict aceasta combinatie de cate ori 
; este nevoie pentru a ne aduce 1-urile pe pozitiile dorite.

; Prin aceasta metoda, se incearca sa se reduca numarul de operatii 
; pe registri, pentru a evita greselile.