	.file	"figura1-modificado_b.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Tiempo transcurrido (seg): %11.9f // R[0] = %d // R[39999] = %d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.section	.text.startup,"ax",@progbits
.LHOTB2:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$160000, %edi
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	malloc
	movq	%rsp, %rsi
	xorl	%edi, %edi
	movq	%rax, %rbx
	call	clock_gettime
	xorl	%r10d, %r10d
	movl	$s+40000, %r9d
	.p2align 4,,10
	.p2align 3
.L2:
	movl	%r10d, %r8d
	movl	$s, %eax
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L3:
	movl	(%rax), %esi
	addq	$32, %rax
	leal	(%r8,%rsi,2), %esi
	addl	%esi, %edx
	movl	-28(%rax), %esi
	leal	(%rsi,%rsi,2), %edi
	movl	-24(%rax), %esi
	subl	%r8d, %edi
	leal	(%r8,%rsi,2), %esi
	addl	%edi, %ecx
	addl	%esi, %edx
	movl	-20(%rax), %esi
	leal	(%rsi,%rsi,2), %esi
	subl	%r8d, %esi
	leal	(%rsi,%rcx), %edi
	movl	-16(%rax), %ecx
	leal	(%r8,%rcx,2), %ecx
	addl	%ecx, %edx
	movl	-12(%rax), %ecx
	leal	(%rcx,%rcx,2), %ecx
	subl	%r8d, %ecx
	leal	(%rcx,%rdi), %esi
	movl	-8(%rax), %ecx
	leal	(%r8,%rcx,2), %ecx
	addl	%ecx, %edx
	movl	-4(%rax), %ecx
	leal	(%rcx,%rcx,2), %ecx
	subl	%r8d, %ecx
	addl	%esi, %ecx
	cmpq	%rax, %r9
	jne	.L3
	cmpl	%ecx, %edx
	cmovg	%ecx, %edx
	movl	%edx, (%rbx,%r10,4)
	addq	$1, %r10
	cmpq	$40000, %r10
	jne	.L2
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	$.LC1, %esi
	pxor	%xmm0, %xmm0
	movl	159996(%rbx), %ecx
	movl	(%rbx), %edx
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC0(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	movq	%rbx, %rdi
	call	free
	xorl	%eax, %eax
	movq	40(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L9
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE2:
	.section	.text.startup
.LHOTE2:
	.comm	s,40000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
