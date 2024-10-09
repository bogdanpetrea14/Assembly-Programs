%include "../include/io.mac"

section .data
    aux1 DD 0
    aux2 DD 0
section .text
	global checkers
    extern printf

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x - linia
    mov ebx, [ebp + 12]	; y - coloana
    mov ecx, [ebp + 16] ; table
    ; PRINTF32 `%d %d\n\n\x0`, eax, ebx
    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    cmp eax, 0
    je prima_linie

    cmp eax, 7
    je ultima_coloana

    cmp ebx, 0
    je laterala1

    cmp ebx, 7
    je laterala2

    jmp middle

laterala1:
    dec eax
    add byte [ecx + 8 * eax + 1], 1
    add eax, 2
    add byte [ecx + 8 * eax + 1], 1
    dec eax
    jmp end

laterala2:
    dec eax
    add byte [ecx + 8 * eax + 6], 1
    add eax, 2
    add byte [ecx + 8 * eax + 6], 1
    dec eax
    jmp end

prima_linie:
    cmp ebx, 0
    je c1 ; coltul din stanga de jos

    cmp ebx, 7
    je c2 ; coltul din dreapta jos

    jmp els1 ; oriunde pe prima linie inafara de cele doua colturi

ultima_coloana:
    cmp ebx, 0
    je c3 ; coltul din stanga sus

    cmp ebx, 7
    je c4 ; coltul din dreapta sus

    jmp els2 ; oriunde pe ultima linie inafara de cele doua colturi


c1:
    add byte [ecx + 9], 1
    jmp end

c2: 
    add byte [ecx + 14], 1
    jmp end

c3:
    add byte [ecx + 49], 1
    jmp end

c4:
    add byte [ecx + 54], 1
    jmp end

els1:
    add byte [ecx + ebx + 7], 1
    add byte [ecx + ebx + 9], 1
    jmp end

els2:
    add byte [ecx + 47 + ebx], 1
    add byte [ecx + 49 + ebx], 1
    jmp end

middle:
    dec eax
    dec ebx
    
    xor edx, edx
    push eax
    push ebx
    mov ebx, 8
    mul ebx
    xor ebx, ebx
    pop ebx
    mov edx, eax
    add edx, ebx
    xor eax, eax
    pop eax

    add byte [ecx + edx], 1


    add ebx, 2

    xor edx, edx
    push eax
    push ebx
    mov ebx, 8
    mul ebx
    xor ebx, ebx
    pop ebx
    mov edx, eax
    add edx, ebx
    xor eax, eax
    pop eax

    add byte [ecx + edx], 1


    add eax, 2

    xor edx, edx
    push eax
    push ebx
    mov ebx, 8
    mul ebx
    xor ebx, ebx
    pop ebx
    mov edx, eax
    add edx, ebx
    xor eax, eax
    pop eax

    add byte [ecx + edx], 1

    
    dec ebx
    dec ebx

    xor edx, edx
    push eax
    push ebx
    mov ebx, 8
    mul ebx
    xor ebx, ebx
    pop ebx
    mov edx, eax
    add edx, ebx
    xor eax, eax
    pop eax

    add byte [ecx + edx], 1


    jmp end
    
end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; Se observa faptul ca exista mai multe cazuri, care pot 
; fi luate individual. Initial, se verifica colturile, pentru 
; care se va pune 1 pe o pozitie deja calculata (cum avem o tabla de 
; dame, aceasta va fi mereu de 8x8=64 de pozitii). Ulterior, se vor 
; pune 1-uri pe pozitii calculate la input.