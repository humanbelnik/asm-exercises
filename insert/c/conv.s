	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0	sdk_version 13, 3
	.intel_syntax noprefix
	.globl	_foo                            ## -- Begin function foo
	.p2align	4, 0x90
_foo:                                   ## @foo
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
                                        ## kill: def $esi killed $esi def $rsi
                                        ## kill: def $edi killed $edi def $rdi
	lea	eax, [rdi + rsi]
	add	eax, edx
	add	eax, ecx
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	lea	rdi, [rip + L_.str]
	mov	esi, 6
	xor	eax, eax
	call	_printf
	xor	eax, eax
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d\n"

.subsections_via_symbols



_my_strcpy:
    cmp     rdi, rsi
    je      .forward_copy

    test    rdx, rdx
    jz      .exit
    lea     rbx, [rsi + rdx]

    .backward_copy:
        mov     al, [rbx - 1]       
        mov     [rdi + rdx - 1], al 
        dec     rbx                  
        dec     rdx                  
        test    rdx, rdx             
        jz      .exit                
        jmp     .backward_copy       

    
    .forward_copy:
        test    rdx, rdx
        jz      .exit


        .copy_loop:
            mov     al, [rsi]           
            mov     [rdi], al           
            inc     rsi                
            inc     rdi                

            test    rdx, rdx            
            jz      .exit               
            jmp     .copy_loop          

    .exit:
        ret   