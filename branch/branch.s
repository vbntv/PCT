	.file	"branch.c"
	.text
	.p2align 4,,15
	.globl	blend_map
	.type	blend_map, @function
blend_map:
.LFB45:
	.cfi_startproc
	testl	%ecx, %ecx
	je	.L1
	leal	-1(%rcx), %eax
	movl	$255, %r9d
	subl	%r8d, %r9d
	movsd	.LC0(%rip), %xmm2
	leaq	8(,%rax,8), %rcx
	xorl	%eax, %eax
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L3:
	testl	%r8d, %r8d
	movsd	(%rdx,%rax), %xmm1
	jne	.L5
	movsd	%xmm1, (%rdi,%rax)
.L4:
	addq	$8, %rax
	cmpq	%rax, %rcx
	je	.L1
.L6:
	cmpl	$255, %r8d
	jne	.L3
	movsd	(%rsi,%rax), %xmm0
	movsd	%xmm0, (%rdi,%rax)
	addq	$8, %rax
	cmpq	%rax, %rcx
	jne	.L6
.L1:
	rep ret
	.p2align 4,,10
	.p2align 3
.L5:
	pxor	%xmm0, %xmm0
	cvtsi2sd	%r9d, %xmm0
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%r8d, %xmm1
	mulsd	%xmm2, %xmm0
	mulsd	(%rsi,%rax), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdi,%rax)
	jmp	.L4
	.cfi_endproc
.LFE45:
	.size	blend_map, .-blend_map
	.p2align 4,,15
	.globl	blend_map_opt
	.type	blend_map_opt, @function
blend_map_opt:
.LFB46:
	.cfi_startproc
	cmpl	$255, %r8d
	je	.L27
	testl	%r8d, %r8d
	jne	.L28
	testl	%ecx, %ecx
	je	.L29
	leal	-1(%rcx), %eax
	leaq	8(,%rax,8), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	movsd	(%rdx,%rax), %xmm0
	movsd	%xmm0, (%rdi,%rax)
	addq	$8, %rax
	cmpq	%rax, %rcx
	jne	.L20
.L12:
	rep ret
	.p2align 4,,10
	.p2align 3
.L28:
	testl	%ecx, %ecx
	je	.L30
	pxor	%xmm4, %xmm4
	movl	$255, %eax
	pxor	%xmm2, %xmm2
	subl	%r8d, %eax
	movsd	.LC0(%rip), %xmm3
	cvtsi2sd	%r8d, %xmm4
	cvtsi2sd	%eax, %xmm2
	leal	-1(%rcx), %eax
	leaq	8(,%rax,8), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L19:
	movsd	(%rdx,%rax), %xmm0
	movsd	(%rsi,%rax), %xmm1
	mulsd	%xmm2, %xmm0
	mulsd	%xmm4, %xmm1
	mulsd	%xmm3, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdi,%rax)
	addq	$8, %rax
	cmpq	%rax, %rcx
	jne	.L19
	rep ret
	.p2align 4,,10
	.p2align 3
.L27:
	testl	%ecx, %ecx
	je	.L12
	leal	-1(%rcx), %eax
	leaq	8(,%rax,8), %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L15:
	movsd	(%rsi,%rax), %xmm0
	movsd	%xmm0, (%rdi,%rax)
	addq	$8, %rax
	cmpq	%rax, %rdx
	jne	.L15
	rep ret
	.p2align 4,,10
	.p2align 3
.L30:
	rep ret
	.p2align 4,,10
	.p2align 3
.L29:
	rep ret
	.cfi_endproc
.LFE46:
	.size	blend_map_opt, .-blend_map_opt
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"First run (sec.): %.6f\n"
.LC3:
	.string	"Mean of %d runs (sec.): %.6f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB47:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%eax, %eax
	leaq	z(%rip), %rbp
	leaq	y(%rip), %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	hpctimer_wtime@PLT
	movsd	%xmm0, (%rsp)
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L32:
	movsd	(%rbx,%rax), %xmm0
	movsd	%xmm0, 0(%rbp,%rax)
	addq	$8, %rax
	cmpq	$800000, %rax
	jne	.L32
	xorl	%eax, %eax
	call	hpctimer_wtime@PLT
	subsd	(%rsp), %xmm0
	xorl	%eax, %eax
	movsd	%xmm0, (%rsp)
	call	hpctimer_wtime@PLT
	movsd	%xmm0, 8(%rsp)
	movl	$20, %edx
	.p2align 4,,10
	.p2align 3
.L33:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L34:
	movsd	(%rbx,%rax), %xmm0
	movsd	%xmm0, 0(%rbp,%rax)
	addq	$8, %rax
	cmpq	$800000, %rax
	jne	.L34
	subl	$1, %edx
	jne	.L33
	xorl	%eax, %eax
	call	hpctimer_wtime@PLT
	movapd	%xmm0, %xmm1
	leaq	.LC1(%rip), %rsi
	movsd	(%rsp), %xmm0
	movl	$1, %edi
	subsd	8(%rsp), %xmm1
	movl	$1, %eax
	movsd	%xmm1, 8(%rsp)
	call	__printf_chk@PLT
	movsd	8(%rsp), %xmm1
	leaq	.LC3(%rip), %rsi
	movl	$20, %edx
	movl	$1, %edi
	movl	$1, %eax
	divsd	.LC2(%rip), %xmm1
	movapd	%xmm1, %xmm0
	call	__printf_chk@PLT
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE47:
	.size	main, .-main
	.comm	z,800000,32
	.comm	y,800000,32
	.comm	x,800000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1064304640
	.align 8
.LC2:
	.long	0
	.long	1077149696
	.ident	"GCC: (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
