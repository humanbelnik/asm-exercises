	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0	sdk_version 13, 3
	.intel_syntax noprefix
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
	lea	rsi, [rip + L_.str]
	## InlineAsm Start

	xor	al, al
	mov	rdi, rsi
	mov	rcx, -1
	repne		scasb	al, byte ptr es:[rdi]
	neg	rcx
	sub	rcx, 2
	mov	r8, rcx


	## InlineAsm End
	lea	rdi, [rip + L_.str.1]
	mov	edx, 20
	mov	rcx, r8
	xor	eax, eax
	call	_printf
	xor	eax, eax
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_getlen                         ## -- Begin function getlen
	.p2align	4, 0x90
_getlen:                                ## @getlen
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	rdx, rdi
	## InlineAsm Start

	xor	al, al
	mov	rdi, rdx
	mov	rcx, -1
	repne		scasb	al, byte ptr es:[rdi]
	neg	rcx
	sub	rcx, 2
	mov	rdx, rcx


	## InlineAsm End
	mov	rax, rdx
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Calculate my length!"

L_.str.1:                               ## @.str.1
	.asciz	"String surrounded by []:\n[%s]\n\nString's length:\nstdlib strlen(): %zu\nassembly: %zu\n"

.subsections_via_symbols
