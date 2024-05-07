PUBLIC printSignedHex
EXTRN number: word
EXTRN byteNeg: byte

CodeSeg SEGMENT PARA PUBLIC 'CODE'
    assume CS:CodeSeg

printSignedHex proc near
	mov byteNeg, 0

	; Newline
    mov ah, 02h
    mov dl, 10
    int 21h 
    mov dl, 13
    int 21h

	; Took the lower byte
	mov ax, number ; 1011 1101 1101 1111
	and ax, 00FFh  ; 0000 0000 1101 1111

	; Working with lower byte as a number
	; If it's negative => convert 	
	xor bx, bx
	mov bh, al
	shl bx, 1
	jc toNeg
	lp:
	xor bx, bx
	mov bl, al
	mov cl, 4
	shr bx, cl
	mov dl, bl
	cmp dl, 9
	ja toLetter
	add dl, '0'
	jmp output1

	toLetter:
		sub dl, 10d
		add dl, 'A'
		
	output1:
		mov ah, 02h
		cmp byteNeg, 1
		jne print
		mov cl, dl
		mov dl, '-'
		int 21h
		mov dl, cl

		print:
		int 21h

	secondPart:
		mov ax, number
		cmp byteNeg, 1
		je toNeg2
		lp2:
		xor bx, bx
		mov bx, ax
		and bx, 000Fh
		mov dl, bl
		cmp dl, 9
		ja toLetter2
		add dl, '0'
		jmp output2

	toLetter2:
		sub dl, 10d
		add dl, 'A'
	
	output2:
		mov ah, 02h
		int 21h
		jmp finish

	toNeg:
		neg ax
		mov byteNeg, 1
		jmp lp

	toNeg2:
		neg ax
		jmp lp2

	finish:
		ret

printSignedHex ENDP
CodeSeg ENDS

END


