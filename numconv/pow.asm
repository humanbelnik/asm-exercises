.386

PUBLIC printMinPow
EXTRN number: word
EXTRN isNeg: byte

CodeSeg SEGMENT PARA USE16 PUBLIC 'CODE'
    assume CS:CodeSeg

printMinPow proc near
    pusha
    
	; Newline
    mov ah, 02h
    mov dl, 10
    int 21h 
    mov dl, 13
    int 21h

    xor dx, dx
    xor ah, ah

    mov ax, number
    cmp isNeg, 1
    je rev
    lp:
    bsr dx, ax 
    jz zero_case 
    inc dx
zero_case:    
    mov ax, dx
    mov bx, 10000d
    xor dx, dx

    _pd_convert:     
    div bx                       
    mov cx, dx   
    cmp ax, 0                
    jne _pd_print

    cmp bx, 1
    jmp _pd_continue

    _pd_print:
    

    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h

    _pd_continue:
    mov ax, bx
    xor dx, dx
    mov bx, 10d
    div bx
    mov bx, ax

    mov ax, cx

    test bx, bx
    jnz _pd_convert

    popa
    ret

rev:
    neg ax
    jmp lp

printMinPow ENDP
CodeSeg ENDS

END


