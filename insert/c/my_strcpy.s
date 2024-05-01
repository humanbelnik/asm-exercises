section .text
global _my_strcpy

; 32-bit _cdecl calling convention unsupported.
;
; Using AMD64 Calling convention on Intel:
; RDI  - ptr to dest
; RSI  - ptr to src
; RDX  - copy size

; Using 'rep movsb' - copy byte from rsi to rdi 'rcx' times.
; rsi & rdi change determined by the DF flag
; The only situation we need to copy backwards - dst > src && dst - src < len
_my_strcpy:
    cmp rdi, rsi
    je .finish
    jb .forward

    mov rcx, rsi
    add rcx, rdx
    cmp rdi, rcx
    jae .forward

    .backward:
        std
        mov rcx, rdx
        dec rdx
        add rsi, rdx
        add rdi, rdx

        rep movsb     

        cld
        jmp .finish

    .forward:
        mov rcx, rdx
        rep movsb

    .finish:
        ret