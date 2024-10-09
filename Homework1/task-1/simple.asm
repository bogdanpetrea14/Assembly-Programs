%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    ;; Prima data, facem modulo 26 pe edx pentru a sti cu cate pozitii shift-am fiecare litera.
    mov eax, edx
    xor edx, edx
    mov ebx, 26

    div ebx

    xor ebx, ebx
    xor eax, eax
    ;; Aducem cei doi registri folositi pe 0, pentru a fi siguri ca functioneaza bine pe mai departe
start_loop:
    cmp ecx, 0
    je end_loop

    movzx eax, byte [esi]

    sub eax, 65
    add eax, edx
    push edx
    xor edx, edx
    mov ebx, 26
    div ebx
    xor eax, eax
    mov eax, edx
    add eax, 65
    mov edx, ebx
    mov byte [edi], al
    inc esi
    inc edi
    dec ecx
    pop edx
    jmp start_loop

end_loop:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
