; This is a TSR (Terminate-and-stay-resident) program for DOS.
; After compiling and execution all code before 'init' will stay in RAM up until DOS restart.

; We replace DOS handler 08h with our custom handler

; How does it work?  
; 1. INT XX happens in some process
; 2. Execution switches on CS:IP of the XX's interruption-handler from the Table
; 3. Handler does he's work and recovers to the previous program

.model tiny

CODESEG segment
    assume  cs:CODESEG
    org 100h ; Reserve 256 bytes for PSP
main:
    jmp init 
    prevHandlerAddr DD ?   
    speed       DB  1Fh
    time        DB  0

handler proc 
    ; Interruption call guarantees saving only: FLAGS, CS, IP 
    ; In order to recover all previous context we must save values we will edit
    ; in stack

    ; Optional to call PUSHA 
    push ax 
    push cx 
    push dx 

    ; We must increase symbol's printing speed every second.
    ; Interruption may be called more often so we need to check wether
    ; speed up is needed.
    mov ah, 02h
    int 1Ah
    cmp dh, time
    je recoverContext

    mov time, dh
    dec speed

    ; Increase the speed if it's lower than maximal
    test speed, 01Fh
    jnz increaseSpeed
    mov speed, 01Fh

increaseSpeed:
    mov al, 0F3h
    out 60h, al
    mov al, speed
    out 60h, al

recoverContext:
    pop dx 
    pop cx 
    pop ax 

    jmp prevHandlerAddr
handler endp


init:
    ; We take previous interruption-handler from the table and save
    ; it's address in prevHandlerAddr variable
    ; BX 0000:[AL*4], ES - 0000:[(AL*4)+2]

    ; 08h is a timer
    mov ah, 35h 
	mov al, 08h
    int 21h 

    ; Save addr of the pevious handler into the local variable
    mov word ptr prevHandlerAddr, bx ; offset
    mov word ptr prevHandlerAddr + 2, es ; segment

    ; Move our custom interruption handler into the table
    mov dx, OFFSET handler 
    mov ah, 25h 
	mov al, 08h
    int 21h 

    mov dx, OFFSET msg
    mov ah, 09h
    int 21h

    ; Everything above 'init' will be cleared
    mov dx, OFFSET init 
    int 27h
    msg DB "Resident program initialized in memory$", 13, 10
CODESEG ENDS
END main