%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .data
    lop1 DW 0
    lop2 DW 0
    how1 DW 0
    how2 DW 0
    aux1 DW 0
    aux2 DW 0

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY
    ;; Your code starts here
    mov [lop1], ax
    mov [lop2], ax
    dec word [lop1]
    xor eax, eax
    xor ebx, ebx
    
loop1:
    cmp bx, [lop1]
    je end_loop1
    push bx
    mov ax, bx
    inc ax

    xor ebx, ebx
    mov ebx, [edx]
    add ebx, dword [how1]
    mov word [how2], 0

loop2:
     cmp ax, [lop2]
    je end_loop2

    ; push cx
    ; xor cx, cx

    ; mov cx, [edx]
    ; add cx, word [how2]

    ; push ax
    ; mov ax, [ecx + proc.pid]
    ; mov word [aux1], ax

    ; mov ax, [ebx + proc.pid]
    ; mov word [aux2], ax

    ; xor ax, ax
    ; pop ax
    ; push ax
    ; mov ax, word [aux2]
    ; cmp [aux1], ax
    jg swap
; swap_back:
;     pop cx

;     pop ax
;     inc ax
;     add word [how2], 5
;     jmp loop2
; swap:
;     push ax
;     xor ax, ax
;     mov ax, bx
;     push esi
;     mov esi, dword [how2]
;     mov [edx + esi], ax
;     pop esi
    
;     mov ax, cx
;     push esi
;     mov esi, dword [how1]
;     mov [edx + esi], ax
;     pop esi
;     xor ax, ax
;     pop ax
    jmp swap_back
end_loop2:
    pop bx
    inc bx
    add word [how1], 5
    jmp loop1
end_loop1:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
