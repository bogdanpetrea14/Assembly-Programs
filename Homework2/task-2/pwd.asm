section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	cont DD 0
	; declare global vars here

section .text
	global pwd

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0
	pusha
	push ebx
	push esi
	push edi

	mov esi, [ebp + 8]
	mov ecx, [ebp + 12]
	mov edi, [ebp + 16]

	; mov [edx], ceva ca sa bagam string ul rezultat
	xor ebx, ebx
	xor edx, edx
	mov byte [edi], '/'
	inc edi
	mov dword [cont], ecx
loop:
	cmp ebx, dword [cont]
	je end

	mov eax, [esi + 4 * ebx]

	cmp byte [eax], '.'
	je check
	
	xor ecx, ecx
add_path:
	mov dl, byte [eax]
	cmp dl, 0
	je add_slash

	mov byte [edi], dl 
	inc edi
	inc eax
	inc ecx
	jmp add_path



	inc ebx
	jmp loop

check:
	inc eax
	cmp byte [eax], '.'
	jne skip
	jmp go_back

skip:
	inc ebx
	jmp loop

add_slash:
	mov byte [edi], '/'
	inc edi
	inc ebx
	jmp loop

go_back:
	cmp edi, '/'
	je skip
	inc ecx
	push ecx
	push eax
	mov eax, [edi]
contor:
	cmp ecx, 0
	je move
	dec edi
	dec ecx
	jmp contor
move:
	mov [edi], eax
	pop eax
	pop ecx
	inc ebx
	jmp loop

end:
	pop edi
	pop esi
	pop ebx
	popa
	leave
	ret