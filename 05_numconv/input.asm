.386

PUBLIC readSignedDecimal
EXTRN number: word
EXTRN prevNumber: word
EXTRN isNeg: byte

EXTRN panic: byte

EXTRN inputPrompt: byte
EXTRN panicReadingPrompt: byte

CodeSeg SEGMENT PARA USE16 PUBLIC 'CODE'
    assume CS:CodeSeg

readSignedDecimal proc near
    xor dx, dx
    mov prevNumber, 0
    mov isNeg, 0
    
    ; Newline
    mov ah, 02h
    mov dl, 10
    int 21h 
    mov dl, 13
    int 21h
    
    ; Prompt
	mov dx, offset inputPrompt
	mov ah, 09
	int 21h

    xor bx, bx
    xor cx, cx

    _readLoop:
        mov ah, 01h
        int 21h

        cmp al, 0dh
        je _finishReading

        ; Set isNeg flag to '1' if input is negative
        ; in order to convert number to the negative code afterwards.
        cmp al, '-'
        je _setIsNegFlag

        ; Skip '+'. We assume that nuber is positive by default
        cmp al, '+'
        je _readLoop

        ; Final number accumulates in BX.
        ; In order to handle new digit we multiply previous value in BX by 10
        ; Then:
        ;   1. Substract from BX if negative
        ;   2. Add to BX if positive

        ; Overflow being controlled by checking wether current number in BX is greater/less than
        ; a previous one. 
        mov cl, al
        mov ax, 10

        mul bx
        mov bx, ax
        sub cl, '0'
        
        cmp isNeg, 1
        je _subDigit
        add bx, cx

        cmp bx, prevNumber
        jl _panicReading
        mov prevNumber, bx
        jmp _readLoop

        _subDigit:
            sub bx, cx
        
        cmp bx, prevNumber
        jg _panicReading
        mov prevNumber, bx
        jmp _readLoop
        
    
    _finishReading:
        mov number, bx
        jmp _finish

    _panicReading: 
        mov ah, 02h
        mov dl, 10
        int 21h 
        mov dl, 13
        int 21h 
        mov dx, offset panicReadingPrompt
        mov ah, 09
	    int 21h
        mov panic, 1
        
    _finish:
        ret

    _setIsNegFlag:
        mov isNeg, 1
        jmp _readLoop


readSignedDecimal ENDP

CodeSeg ENDS
END






