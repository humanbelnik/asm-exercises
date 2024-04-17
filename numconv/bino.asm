.386

PUBLIC printBino
EXTRN number: word
EXTRN isNeg: byte

CodeSeg SEGMENT PARA USE16 PUBLIC 'CODE'
    assume CS:CodeSeg

printBino proc near
    pusha

    ; Newline
    mov ah, 02h
    mov dl, 10
    int 21h 
    mov dl, 13
    int 21h

    xor dx, dx
    xor cx, cx


    mov ax, number
    cmp isNeg, 1
    je rev
    lp:
    mov bx, ax
    bsr cx, ax
    jz zeroCase
    mov ax, bx
    xor cx, cx

    shr bx, 1
    jc toZeroPower

    _div_loop:
        shr ax, 1
        jc _end
        inc cx
    _no_of:
        cmp ax, 1
        jne _div_loop 
    ;mov dx, 2
    ;dec cx
    ;shl dx, cl
    ;cmp ax, dx
    ;jne toZeroPower
    _end:
    ;inc cx
    mov ax, cx
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




    ;mov dl, cl
    ;inc dl
    ;add dl, '0'
    ;mov ah, 02h
    ;int 21h
    jmp finish
    
    zeroCase:
        mov ah, 02h
        mov dl, '-'
        int 21h
        jmp finish

    toZeroPower:
        mov ah, 02h
        mov dl, '0'
        int 21h
        jmp finish

    rev:
        neg ax
        jmp lp

    finish:
        popa
        ret

printBino ENDP
CodeSeg ENDS

END


