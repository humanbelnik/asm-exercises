; REPL (Read-eval print loop) application to convert numbers
; 
; INPUT: Signed 16-bit decimal 
; OUTPUT #1: Number in unsigned binary representation
; OUTPUT #2: Lower numbers's byte in hex signed representation
; OUTPUT #3: Power of 2 that's greater than number in unsigned representation.
PUBLIC number 
PUBLIC prevNumber 

PUBLIC byteNeg
PUBLIC isNeg
PUBLIC panic
 
PUBLIC inputPrompt
PUBLIC panicReadingPrompt

EXTRN readSignedDecimal: near
EXTRN printUnsignedBin: near
EXTRN printSignedHex: near
EXTRN printMinPow: near
EXTRN printBino: near

StackSeg SEGMENT PARA STACK 'STACK'
    db 100h dup(0)
StackSeg ENDS

DataSeg SEGMENT PARA PUBLIC 'DATA'
    number dw 0
    prevNumber dw 0

    ; Flags to determine wether number is negative or not  
    isNeg db 0
    byteNeg db 0

    ; Variable to check if there was an error while readning input
    panic db 0

	menu db 10, 13, 'Menu: ', 10, 13
		 db " 0. Input signed decimal number", 10, 13
		 db " 1. Output unsigned binary number", 10, 13
		 db " 2. Output signed hexidemical number", 10, 13
         db " 3. Output minimal power of two that is greater than input number", 10, 13
		 db " 4. Exit", 10, 13
         db " Input:  $", 10, 13

    inputPrompt db "Input (-32768; 32767): $"
    panicReadingPrompt db "Panic: 16-bit integer overflow. $"

    funcPtrList dw readSignedDecimal, printUnsignedBin, printSignedHex, printMinPow, exit, printBino
DataSeg ENDS

CodeSeg SEGMENT PARA  PUBLIC 'CODE'
    assume DS:DataSeg, CS:CodeSeg, SS:StackSEG

exit proc near
    mov ah, 4Ch
    int 21h
    ret
exit endp

main:
    ; Link data segment
    mov ax, DataSeg
    mov ds, ax

    ; Main application loop
    _appLoop:
        cmp panic, 1
        je _panicExit 

        xor cx, cx

        ; Print menu
        mov ah, 09h
        mov dx, offset menu
        int 21h
    
        mov ah, 01h 
        int 21h 
        xor ah, ah
        sub al, '0'
        ; All functions declared as 'near' => addr is 2 byte
        mov dl, 02
        mul dl
        mov bx, ax 
        call funcPtrList[bx]
        jmp _appLoop
    
    _panicExit:
        call exit

CodeSeg ends

end main
