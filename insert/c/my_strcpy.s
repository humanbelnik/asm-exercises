section .text
global _my_strcpy

_my_strcpy:
    ; [rdi] - указатель на целевую строку (dest)
    ; [rsi] - указатель на исходную строку (src)
    ; [rdx] - длина строки (len)

    test    rdx, rdx
    jz      .exit

    .copy_loop:
        movsb                    
        dec     rdx              
        jnz     .copy_loop        

    .exit:

        ret  