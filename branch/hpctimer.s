	.file	"hpctimer.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"hpctimer: Initializing timer..."
	.align 8
.LC3:
	.string	"hpctimer: TSC ticks per second: %lu (%.2f GHz)\n"
	.text
	.p2align 4,,15
	.type	hpctimer_tsc_initialize, @function
hpctimer_tsc_initialize:
.LFB65:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC0(%rip), %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	$-2, %rbp
	call	puts@PLT
	movl	$10, %r8d
	.p2align 4,,10
	.p2align 3
.L2:
#APP
# 129 "hpctimer.c" 1
	xorl %eax, %eax
cpuid

# 0 "" 2
# 134 "hpctimer.c" 1
	rdtsc

# 0 "" 2
#NO_APP
	movl	%edx, %esi
	movl	%eax, %edi
#APP
# 129 "hpctimer.c" 1
	xorl %eax, %eax
cpuid

# 0 "" 2
# 134 "hpctimer.c" 1
	rdtsc

# 0 "" 2
#NO_APP
	salq	$32, %rdx
	salq	$32, %rsi
	movl	%eax, %eax
	orq	%rax, %rdx
	orq	%rdi, %rsi
	subq	%rsi, %rdx
	cmpq	%rdx, %rbp
	cmova	%rdx, %rbp
	subl	$1, %r8d
	jne	.L2
	movq	%rbp, hpctimer_overhead(%rip)
#APP
# 129 "hpctimer.c" 1
	xorl %eax, %eax
cpuid

# 0 "" 2
# 134 "hpctimer.c" 1
	rdtsc

# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	movl	$3, %edi
	orq	%rax, %rdx
	movq	%rdx, %r12
	call	sleep@PLT
#APP
# 129 "hpctimer.c" 1
	xorl %eax, %eax
cpuid

# 0 "" 2
# 134 "hpctimer.c" 1
	rdtsc

# 0 "" 2
#NO_APP
	movq	%rdx, %rcx
	movl	%eax, %edx
	salq	$32, %rcx
	orq	%rdx, %rcx
	movabsq	$-6148914691236517205, %rdx
	subq	%r12, %rcx
	subq	%rbp, %rcx
	movq	%rcx, %rax
	mulq	%rdx
	shrq	%rdx
	testq	%rcx, %rcx
	movq	%rdx, %rbp
	js	.L3
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rcx, %xmm0
.L4:
	divsd	.LC1(%rip), %xmm0
	leaq	.LC3(%rip), %rsi
	movq	%rbp, %rdx
	movl	$1, %edi
	movl	$1, %eax
	mulsd	.LC2(%rip), %xmm0
	call	__printf_chk@PLT
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, hpctimer_freq(%rip)
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	.cfi_restore_state
	movq	%rcx, %rax
	pxor	%xmm0, %xmm0
	shrq	%rax
	andl	$1, %ecx
	orq	%rcx, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L4
	.cfi_endproc
.LFE65:
	.size	hpctimer_tsc_initialize, .-hpctimer_tsc_initialize
	.p2align 4,,15
	.globl	hpctimer_initialize
	.type	hpctimer_initialize, @function
hpctimer_initialize:
.LFB61:
	.cfi_startproc
	xorl	%eax, %eax
	movl	$1, isinitialized(%rip)
	jmp	hpctimer_tsc_initialize
	.cfi_endproc
.LFE61:
	.size	hpctimer_initialize, .-hpctimer_initialize
	.p2align 4,,15
	.globl	hpctimer_wtime
	.type	hpctimer_wtime, @function
hpctimer_wtime:
.LFB63:
	.cfi_startproc
	movl	isinitialized(%rip), %eax
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	testl	%eax, %eax
	jne	.L10
	xorl	%eax, %eax
	movl	$1, isinitialized(%rip)
	call	hpctimer_tsc_initialize
.L10:
#APP
# 129 "hpctimer.c" 1
	xorl %eax, %eax
cpuid

# 0 "" 2
# 134 "hpctimer.c" 1
	rdtsc

# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	orq	%rax, %rdx
	subq	hpctimer_overhead(%rip), %rdx
	js	.L11
	movq	hpctimer_freq(%rip), %rax
	pxor	%xmm0, %xmm0
	testq	%rax, %rax
	cvtsi2sdq	%rdx, %xmm0
	js	.L13
.L16:
	pxor	%xmm1, %xmm1
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	cvtsi2sdq	%rax, %xmm1
	divsd	%xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	movq	hpctimer_freq(%rip), %rax
	testq	%rax, %rax
	addsd	%xmm0, %xmm0
	jns	.L16
.L13:
	movq	%rax, %rdx
	pxor	%xmm1, %xmm1
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm1
	popq	%rbx
	.cfi_def_cfa_offset 8
	addsd	%xmm1, %xmm1
	divsd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE63:
	.size	hpctimer_wtime, .-hpctimer_wtime
	.p2align 4,,15
	.globl	hpctimer_sanity_check
	.type	hpctimer_sanity_check, @function
hpctimer_sanity_check:
.LFB62:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pxor	%xmm1, %xmm1
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	$1, %ebp
	movl	$1, %ebx
	xorl	%r12d, %r12d
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
.L18:
	xorl	%eax, %eax
	movsd	%xmm1, 8(%rsp)
	call	hpctimer_wtime
	movl	%ebx, %edi
	movsd	%xmm0, (%rsp)
	call	sleep@PLT
	xorl	%eax, %eax
	call	hpctimer_wtime
	cmpl	$1, %ebx
	subsd	(%rsp), %xmm0
	je	.L19
	pxor	%xmm2, %xmm2
	movsd	8(%rsp), %xmm1
	cvtsi2sd	%ebx, %xmm2
	divsd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	mulsd	.LC6(%rip), %xmm1
	subsd	%xmm0, %xmm2
	andpd	.LC5(%rip), %xmm2
	ucomisd	%xmm1, %xmm2
	cmova	%r12d, %ebp
	cmpl	$3, %ebx
	jne	.L19
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movl	%ebp, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	.cfi_restore_state
	addl	$1, %ebx
	movapd	%xmm0, %xmm1
	jmp	.L18
	.cfi_endproc
.LFE62:
	.size	hpctimer_sanity_check, .-hpctimer_sanity_check
	.local	hpctimer_freq
	.comm	hpctimer_freq,8,8
	.local	hpctimer_overhead
	.comm	hpctimer_overhead,8,8
	.local	isinitialized
	.comm	isinitialized,4,4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1074266112
	.align 8
.LC2:
	.long	3894859413
	.long	1041313291
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC5:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC6:
	.long	2576980378
	.long	1068079513
	.ident	"GCC: (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
