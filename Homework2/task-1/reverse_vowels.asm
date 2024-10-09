section .data
	; declare global vars here

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	pop esi
	pop eax ; se lucreaza doar cu ebx-ul
	xor ecx, ecx ; folosim ca un contor pentru string

loop:
	cmp byte [eax + ecx], 0
	je second

	cmp byte [eax + ecx], 'a'
	je vowel

	cmp byte [eax + ecx], 'e'
	je vowel

	cmp byte [eax + ecx], 'i'
	je vowel

	cmp byte [eax + ecx], 'o'
	je vowel

	cmp byte [eax + ecx], 'u'
	je vowel

back:
	inc ecx
	jmp loop

vowel:
	xor edx, edx
	add edx, [eax + ecx]
	push edx
	jmp back

second:
	xor ecx, ecx

loop2:
	cmp byte [eax + ecx], 0
	je end

	cmp byte [eax + ecx], 'a'
	je reva

	cmp byte [eax + ecx], 'e'
	je reve

	cmp byte [eax + ecx], 'i'
	je revi

	cmp byte [eax + ecx], 'o'
	je revo

	cmp byte [eax + ecx], 'u'
	je revu

back2:
	inc ecx
	jmp loop2

reva:
	xor edx, edx
	sub byte [eax + ecx], 'a'
	pop edx
	add byte [eax + ecx], dl
	jmp back2

reve:
	xor edx, edx
	sub byte [eax + ecx], 'e'
	pop edx
	add byte [eax + ecx], dl
	jmp back2

revi:
	xor edx, edx
	sub byte [eax + ecx], 'i'
	pop edx
	add byte [eax + ecx], dl
	jmp back2

revu:
	xor edx, edx
	sub byte [eax + ecx], 'u'
	pop edx
	add byte [eax + ecx], dl
	jmp back2

revo:
	xor edx, edx
	sub byte [eax + ecx], 'o'
	pop edx
	add byte [eax + ecx], dl
	jmp back2

end:
	push eax
	push esi
	ret