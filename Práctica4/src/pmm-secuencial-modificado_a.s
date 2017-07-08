	.file	"pmm-secuencial-modificado_a.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Modo de empleo: %s, N\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"No se ha podido reservar memoria"
	.section	.rodata.str1.1
.LC4:
	.string	"[%.1f]"
.LC5:
	.string	"[%.2f]"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"Tiempo(seg.): %11.9f \nTama\303\261o: %u \nB[0][0]*C[0][0]=A[0][0] = %.1f \nB[%d][%d]*C[%d][%d]=A[%d][%d] = %.2f \n"
	.align 8
.LC8:
	.string	"Tiempo transcurrido (seg): %11.9f \n\nMatriz 1 generada:\n"
	.section	.rodata.str1.1
.LC9:
	.string	"\n\nMatriz 2 generada:"
.LC10:
	.string	"\n\nResultado:"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB11:
	.section	.text.startup,"ax",@progbits
.LHOTB11:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L42
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, %r14d
	movl	%eax, %r13d
	movq	%rax, 8(%rsp)
	imull	%eax, %r14d
	movslq	%r14d, %r14
	salq	$3, %r14
	leaq	63(%r14), %rbx
	movq	%rbx, %rdi
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, %r15
	movq	%rax, 16(%rsp)
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, %r12
	movq	%rax, 24(%rsp)
	leaq	63(%r15), %rbp
	leaq	63(%r12), %r12
	call	malloc
	leaq	63(%rax), %rbx
	movq	%rax, 32(%rsp)
	andq	$-64, %rbx
	andq	$-64, %rbp
	sete	%cl
	andq	$-64, %r12
	movq	%rbp, (%rsp)
	sete	%al
	orb	%al, %cl
	jne	.L3
	testq	%rbx, %rbx
	je	.L3
	movq	8(%rsp), %rdx
	testl	%edx, %edx
	jle	.L4
	pxor	%xmm2, %xmm2
	leal	-1(%rdx), %r9d
	movslq	%edx, %rax
	movsd	.LC1(%rip), %xmm3
	movq	%r12, %rsi
	salq	$3, %r9
	movq	%rbx, %rcx
	leaq	0(,%rax,8), %r15
	cvtsi2sd	%edx, %xmm2
	leaq	8(%r9), %r11
	movq	%rax, 8(%rsp)
	movq	%rbp, %r10
	xorl	%edi, %edi
	subq	%rbp, %rsi
	subq	%rbp, %rcx
	mulsd	%xmm3, %xmm2
.L5:
	pxor	%xmm0, %xmm0
	movapd	%xmm2, %xmm4
	movapd	%xmm2, %xmm1
	leaq	(%r11,%r10), %rdx
	movq	%r10, %rax
	cvtsi2sd	%edi, %xmm0
	mulsd	%xmm3, %xmm0
	subsd	%xmm0, %xmm4
	addsd	%xmm0, %xmm1
	movapd	%xmm4, %xmm0
	.p2align 4,,10
	.p2align 3
.L6:
	movq	$0, (%rax)
	movsd	%xmm1, (%rsi,%rax)
	movsd	%xmm0, (%rcx,%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L6
	addl	$1, %edi
	addq	%r15, %r10
	cmpl	%r13d, %edi
	jne	.L5
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	movq	%r9, 40(%rsp)
	call	clock_gettime
	movq	40(%rsp), %r9
	movq	(%rsp), %r11
	movq	%r12, %rdi
	xorl	%edx, %edx
	leaq	8(%rbx,%r9), %r10
	subq	%r12, %r11
.L21:
	leaq	(%r11,%rdi), %rsi
	movq	%rbx, %r8
	.p2align 4,,10
	.p2align 3
.L11:
	movsd	(%rsi), %xmm1
	movq	%r8, %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L8:
	movsd	(%rdi,%rax,8), %xmm0
	addq	$1, %rax
	mulsd	(%rcx), %xmm0
	addq	%r15, %rcx
	cmpl	%eax, %r13d
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%rsi)
	jg	.L8
	addq	$8, %r8
	addq	$8, %rsi
	cmpq	%r10, %r8
	jne	.L11
	addl	$1, %edx
	addq	%r15, %rdi
	cmpl	%r13d, %edx
	jne	.L21
	leaq	64(%rsp), %rsi
	xorl	%edi, %edi
	movl	%edx, 40(%rsp)
	call	clock_gettime
	movq	72(%rsp), %rax
	subq	56(%rsp), %rax
	pxor	%xmm0, %xmm0
	movl	40(%rsp), %edx
	cvtsi2sdq	%rax, %xmm0
	movq	64(%rsp), %rax
	subq	48(%rsp), %rax
	cmpl	$11, %edx
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC7(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	jle	.L43
	leal	-1(%rdx), %ecx
	pushq	%rax
	.cfi_def_cfa_offset 168
	movl	$.LC6, %esi
	movl	$1, %edi
	pushq	%rcx
	.cfi_def_cfa_offset 176
	pushq	%rcx
	.cfi_def_cfa_offset 184
	movl	%ecx, %r9d
	pushq	%rcx
	.cfi_def_cfa_offset 192
	movq	32(%rsp), %rax
	movl	%ecx, %r8d
	movsd	-8(%r14,%rax), %xmm2
	movsd	(%rax), %xmm1
	movl	$3, %eax
	call	__printf_chk
	addq	$32, %rsp
	.cfi_def_cfa_offset 160
.L20:
	movq	16(%rsp), %rdi
	call	free
	movq	24(%rsp), %rdi
	call	free
	movq	32(%rsp), %rdi
	call	free
	xorl	%edi, %edi
	call	exit
.L3:
	movl	$.LC2, %edi
	call	puts
	orl	$-1, %edi
	call	exit
.L42:
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC0, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L43:
	movl	$.LC8, %esi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk
	movq	8(%rsp), %rax
	xorl	%r15d, %r15d
	leaq	0(,%rax,8), %r14
.L13:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	(%r12,%rbp,8), %xmm0
	movl	$.LC4, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %rbp
	call	__printf_chk
	cmpl	%ebp, %r13d
	jg	.L12
	movl	$10, %edi
	addl	$1, %r15d
	addq	%r14, %r12
	call	putchar
	cmpl	%r13d, %r15d
	jl	.L13
	movl	$.LC9, %edi
	xorl	%r12d, %r12d
	call	puts
.L16:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L15:
	movsd	(%rbx,%rbp,8), %xmm0
	movl	$.LC4, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %rbp
	call	__printf_chk
	cmpl	%ebp, %r13d
	jg	.L15
	movl	$10, %edi
	addl	$1, %r12d
	addq	%r14, %rbx
	call	putchar
	cmpl	%r13d, %r12d
	jl	.L16
	movl	$.LC10, %edi
	xorl	%ebx, %ebx
	call	puts
	movq	8(%rsp), %r14
	movq	(%rsp), %rbp
	salq	$3, %r14
.L19:
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L18:
	movsd	0(%rbp,%r12,8), %xmm0
	movl	$.LC5, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %r12
	call	__printf_chk
	cmpl	%r12d, %r13d
	jg	.L18
	movl	$10, %edi
	addl	$1, %ebx
	addq	%r14, %rbp
	call	putchar
	cmpl	%r13d, %ebx
	jl	.L19
.L22:
	movl	$10, %edi
	call	putchar
	jmp	.L20
.L4:
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	leaq	64(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	72(%rsp), %rax
	subq	56(%rsp), %rax
	movl	$.LC8, %esi
	pxor	%xmm0, %xmm0
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	64(%rsp), %rax
	subq	48(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC7(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	movl	$.LC9, %edi
	call	puts
	movl	$.LC10, %edi
	call	puts
	jmp	.L22
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE11:
	.section	.text.startup
.LHOTE11:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	2576980378
	.long	1069128089
	.align 8
.LC7:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
