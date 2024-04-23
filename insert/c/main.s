	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0	sdk_version 13, 3
	.intel_syntax noprefix
	.globl	_strlen_test                    ## -- Begin function strlen_test
	.p2align	4, 0x90
_strlen_test:                           ## @strlen_test
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 96
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	lea	rdi, [rbp - 80]
	xor	esi, esi
	mov	edx, 64
	call	_memset
	lea	rax, [rip + L_.str]
	mov	qword ptr [rbp - 80], rax
	lea	rax, [rip + L_.str.1]
	mov	qword ptr [rbp - 72], rax
	lea	rax, [rip + L_.str.2]
	mov	qword ptr [rbp - 48], rax
	lea	rax, [rip + L_.str.3]
	mov	qword ptr [rbp - 40], rax
	mov	qword ptr [rbp - 32], 14
	mov	qword ptr [rbp - 88], 2
	mov	qword ptr [rbp - 96], 0
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 96]
	cmp	rax, qword ptr [rbp - 88]
	jae	LBB0_7
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	mov	rsi, qword ptr [rbp - 96]
	add	rsi, 1
	mov	rcx, qword ptr [rbp - 96]
	lea	rax, [rbp - 80]
	shl	rcx, 5
	add	rax, rcx
	mov	rdx, qword ptr [rax]
	lea	rdi, [rip + L_.str.4]
	mov	al, 0
	call	_printf
	mov	rcx, qword ptr [rbp - 96]
	lea	rax, [rbp - 80]
	shl	rcx, 5
	add	rax, rcx
	mov	rdi, qword ptr [rax + 8]
	call	_my_strlen
	mov	rcx, rax
	mov	rdx, qword ptr [rbp - 96]
	lea	rax, [rbp - 80]
	shl	rdx, 5
	add	rax, rdx
	mov	qword ptr [rax + 24], rcx
	mov	rcx, qword ptr [rbp - 96]
	lea	rax, [rbp - 80]
	shl	rcx, 5
	add	rax, rcx
	mov	rax, qword ptr [rax + 24]
	mov	rdx, qword ptr [rbp - 96]
	lea	rcx, [rbp - 80]
	shl	rdx, 5
	add	rcx, rdx
	cmp	rax, qword ptr [rcx + 16]
	sete	al
	xor	al, -1
	and	al, 1
	movzx	eax, al
	cdqe
	cmp	rax, 0
	je	LBB0_4
## %bb.3:
	lea	rdi, [rip + L___func__.strlen_test]
	lea	rsi, [rip + L_.str.5]
	lea	rcx, [rip + L_.str.6]
	mov	edx, 36
	call	___assert_rtn
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_5
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rip + L_.str.7]
	mov	al, 0
	call	_printf
## %bb.6:                               ##   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rbp - 96]
	add	rax, 1
	mov	qword ptr [rbp - 96], rax
	jmp	LBB0_1
LBB0_7:
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	rcx, qword ptr [rbp - 8]
	cmp	rax, rcx
	jne	LBB0_9
## %bb.8:
	add	rsp, 96
	pop	rbp
	ret
LBB0_9:
	call	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.globl	_my_strlen                      ## -- Begin function my_strlen
	.p2align	4, 0x90
_my_strlen:                             ## @my_strlen
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	qword ptr [rbp - 8], rdi
	mov	qword ptr [rbp - 16], 0
	mov	rdx, qword ptr [rbp - 8]
	## InlineAsm Start

	xor	al, al
	mov	rdi, rdx
	mov	rcx, -1
	repne		scasb	al, byte ptr es:[rdi]
	neg	rcx
	sub	rcx, 2
	mov	rdx, rcx


	## InlineAsm End
	mov	qword ptr [rbp - 24], rdx       ## 8-byte Spill
	mov	rax, qword ptr [rbp - 24]       ## 8-byte Reload
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rbp - 16]
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_strcpy_test                    ## -- Begin function strcpy_test
	.p2align	4, 0x90
_strcpy_test:                           ## @strcpy_test
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 272
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rip + L___const.strcpy_test.s_first]
	mov	qword ptr [rbp - 20], rax
	mov	eax, dword ptr [rip + L___const.strcpy_test.s_first+8]
	mov	dword ptr [rbp - 12], eax
	mov	rax, qword ptr [rip + L___const.strcpy_test.s_second]
	mov	qword ptr [rbp - 48], rax
	mov	rax, qword ptr [rip + L___const.strcpy_test.s_second+8]
	mov	qword ptr [rbp - 40], rax
	lea	rax, [rip + L_.str.8]
	mov	qword ptr [rbp - 208], rax
	lea	rax, [rbp - 48]
	mov	qword ptr [rbp - 200], rax
	lea	rax, [rbp - 20]
	mov	qword ptr [rbp - 192], rax
	lea	rdi, [rbp - 20]
	call	_strlen
	mov	qword ptr [rbp - 184], rax
	lea	rax, [rip + L_.str.9]
	mov	qword ptr [rbp - 176], rax
	lea	rax, [rip + L_.str.10]
	mov	qword ptr [rbp - 168], rax
	lea	rax, [rbp - 20]
	mov	qword ptr [rbp - 160], rax
	lea	rax, [rbp - 20]
	mov	qword ptr [rbp - 152], rax
	lea	rdi, [rbp - 20]
	call	_strlen
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + L_.str.11]
	mov	qword ptr [rbp - 136], rax
	lea	rax, [rip + L_.str.12]
	mov	qword ptr [rbp - 128], rax
	lea	rax, [rbp - 20]
	mov	qword ptr [rbp - 120], rax
	lea	rax, [rbp - 20]
	add	rax, 5
	mov	qword ptr [rbp - 112], rax
	mov	qword ptr [rbp - 104], 6
	lea	rax, [rip + L_.str.13]
	mov	qword ptr [rbp - 96], rax
	lea	rax, [rip + L_.str.14]
	mov	qword ptr [rbp - 88], rax
	lea	rax, [rbp - 20]
	mov	qword ptr [rbp - 80], rax
	lea	rax, [rbp - 20]
	add	rax, 1
	mov	qword ptr [rbp - 72], rax
	lea	rdi, [rbp - 20]
	call	_strlen
	mov	qword ptr [rbp - 64], rax
	lea	rax, [rip + L_.str.15]
	mov	qword ptr [rbp - 56], rax
	mov	qword ptr [rbp - 216], 4
	mov	qword ptr [rbp - 224], 0
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 224]
	cmp	rax, qword ptr [rbp - 216]
	jae	LBB2_7
## %bb.2:                               ##   in Loop: Header=BB2_1 Depth=1
	lea	rsi, [rbp - 208]
	imul	rax, qword ptr [rbp - 224], 40
	add	rsi, rax
	lea	rdi, [rbp - 264]
	mov	edx, 40
	call	_memcpy
	mov	rsi, qword ptr [rbp - 224]
	add	rsi, 1
	mov	rdx, qword ptr [rbp - 264]
	lea	rdi, [rip + L_.str.4]
	mov	al, 0
	call	_printf
	mov	rdi, qword ptr [rbp - 256]
	mov	rsi, qword ptr [rbp - 248]
	mov	rdx, qword ptr [rbp - 240]
	call	_my_strcpy
	mov	rdi, qword ptr [rbp - 232]
	mov	rsi, qword ptr [rbp - 256]
	call	_strcmp
	cmp	eax, 0
	sete	al
	xor	al, -1
	and	al, 1
	movzx	eax, al
	cdqe
	cmp	rax, 0
	je	LBB2_4
## %bb.3:
	lea	rdi, [rip + L___func__.strcpy_test]
	lea	rsi, [rip + L_.str.5]
	lea	rcx, [rip + L_.str.16]
	mov	edx, 89
	call	___assert_rtn
LBB2_4:                                 ##   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_5
LBB2_5:                                 ##   in Loop: Header=BB2_1 Depth=1
	lea	rdi, [rip + L_.str.7]
	mov	al, 0
	call	_printf
## %bb.6:                               ##   in Loop: Header=BB2_1 Depth=1
	mov	rax, qword ptr [rbp - 224]
	add	rax, 1
	mov	qword ptr [rbp - 224], rax
	jmp	LBB2_1
LBB2_7:
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	rcx, qword ptr [rbp - 8]
	cmp	rax, rcx
	jne	LBB2_9
## %bb.8:
	add	rsp, 272
	pop	rbp
	ret
LBB2_9:
	call	___stack_chk_fail
	ud2
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
	sub	rsp, 16
	mov	dword ptr [rbp - 4], 0
	call	_strlen_test
	call	_strcpy_test
	xor	eax, eax
	add	rsp, 16
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Length is equal to zero"

L_.str.1:                               ## @.str.1
	.space	1

L_.str.2:                               ## @.str.2
	.asciz	"Length is not zero"

L_.str.3:                               ## @.str.3
	.asciz	"get my length!"

L_.str.4:                               ## @.str.4
	.asciz	"test %zu : %s\n"

L___func__.strlen_test:                 ## @__func__.strlen_test
	.asciz	"strlen_test"

L_.str.5:                               ## @.str.5
	.asciz	"main.c"

L_.str.6:                               ## @.str.6
	.asciz	"tt[i].actual == tt[i].expected"

L_.str.7:                               ## @.str.7
	.asciz	"ok\n"

L___const.strcpy_test.s_first:          ## @__const.strcpy_test.s_first
	.asciz	"some string"

	.p2align	4                               ## @__const.strcpy_test.s_second
L___const.strcpy_test.s_second:
	.asciz	"$$$$$$$$$$$$$$$"

L_.str.8:                               ## @.str.8
	.asciz	"Full copy from the first to a second string"

L_.str.9:                               ## @.str.9
	.asciz	"some string$$$$"

L_.str.10:                              ## @.str.10
	.asciz	"Loop copy"

L_.str.11:                              ## @.str.11
	.asciz	"some string"

L_.str.12:                              ## @.str.12
	.asciz	"From the from to the back"

L_.str.13:                              ## @.str.13
	.asciz	"stringtring"

L_.str.14:                              ## @.str.14
	.asciz	"Crossed"

L_.str.15:                              ## @.str.15
	.asciz	"tringtring"

L___func__.strcpy_test:                 ## @__func__.strcpy_test
	.asciz	"strcpy_test"

L_.str.16:                              ## @.str.16
	.asciz	"strcmp(t.expected, t.dst_ptr) == 0"

.subsections_via_symbols
