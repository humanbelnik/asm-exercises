PUBLIC printUnsignedBin
EXTRN number: word
EXTRN isNeg: byte

CodeSeg SEGMENT PARA PUBLIC 'CODE'
    assume CS:CodeSeg

printUnsignedBin proc near
        ; Newline
        mov ah, 02h
        mov dl, 10
        int 21h 
        mov dl, 13
        int 21h

        mov bx, number                      
    	mov cx, 16                     	
    	mov ah, 02h                         	

        ; OF: |1| <-- 101101... 
    	_digitLoop:
            xor dl, dl
            shl bx, 1  
            jc _printOne                

            mov ah, 02h
            mov dl, '0'
            int 21h
            _lp:
            loop _digitLoop
        jmp _finish

    _printOne:
        mov ah, 02h
        mov dl, '1'
        int 21h
        jmp _lp

    _finish:    
        ret
printUnsignedBin ENDP
CodeSeg ENDS

END