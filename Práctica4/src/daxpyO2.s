	.file	"daxpy.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	daxpy
	.type	daxpy, @function
daxpy:
.LFB38:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%r8, %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	%ecx, %ebp
	movq	%rdi, %rbx
	xorl	%edi, %edi
	movl	%edx, %r12d
	movq	%r9, %r14
	call	clock_gettime
	xorl	%eax, %eax
	testl	%ebp, %ebp
	je	.L4
	.p2align 4,,10
	.p2align 3
.L5:
	movl	0(%r13,%rax,4), %esi
	imull	%r12d, %esi
	addl	%esi, (%rbx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ebp
	ja	.L5
.L4:
	popq	%rbx
	.cfi_def_cfa_offset 40
	movq	%r14, %rsi
	xorl	%edi, %edi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	clock_gettime
	.cfi_endproc
.LFE38:
	.size	daxpy, .-daxpy
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Modo de empleo %s <tama\303\261o> <a>\n"
	.align 8
.LC3:
	.string	"Tiempo (seg.) = %11.9f // y[0] = %i, y[%i] = %i\n"
	.section	.text.unlikely
.LCOLDB4:
	.section	.text.startup,"ax",@progbits
.LHOTB4:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jle	.L20
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbx), %rdi
	movq	%rax, %r12
	xorl	%esi, %esi
	movl	%r12d, %ebp
	movl	$10, %edx
	salq	$2, %rbp
	call	strtol
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	malloc
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	malloc
	testl	%r12d, %r12d
	movq	%rax, %rbp
	je	.L14
	leal	2(%r12), %edx
	xorl	%edi, %edi
	xorl	%esi, %esi
	movl	$2, %eax
	.p2align 4,,10
	.p2align 3
.L13:
	movl	%eax, (%rbx,%rsi)
	addl	$1, %eax
	movl	%edi, 0(%rbp,%rsi)
	addq	$4, %rsi
	addl	$2, %edi
	cmpl	%edx, %eax
	jne	.L13
.L14:
	leaq	16(%rsp), %r9
	movq	%rsp, %r8
	movl	%r12d, %ecx
	movl	%r13d, %edx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	daxpy
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	leal	-1(%r12), %edx
	pxor	%xmm0, %xmm0
	movl	$.LC3, %esi
	pxor	%xmm1, %xmm1
	movq	%rdx, %rcx
	movl	(%rbx,%rdx,4), %r8d
	movl	(%rbx), %edx
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	__printf_chk
	movq	%rbx, %rdi
	call	free
	movq	%rbp, %rdi
	call	free
	xorl	%eax, %eax
	movq	40(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L21
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L20:
	.cfi_restore_state
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC1, %esi
	call	__printf_chk
	movl	$1, %edi
	call	exit
.L21:
	call	__stack_chk_fail
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE4:
	.section	.text.startup
.LHOTE4:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
