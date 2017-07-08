	.file	"pmm-secuencial.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Modo de empleo: %s, N\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L53
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movslq	%eax, %rbp
	movq	%rax, %rbx
	movq	%rax, 16(%rsp)
	salq	$3, %rbp
	movl	%eax, %r13d
	movq	%rbp, %rdi
	call	malloc
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	malloc
	movq	%rbp, %rdi
	movq	%rax, 8(%rsp)
	call	malloc
	testl	%ebx, %ebx
	movq	%rax, %r15
	jle	.L3
	movl	%ebx, %eax
	xorl	%ebx, %ebx
	subl	$1, %eax
	leaq	8(,%rax,8), %r14
	movl	%eax, 28(%rsp)
	.p2align 4,,10
	.p2align 3
.L4:
	movq	%rbp, %rdi
	call	malloc
	movq	%rbp, %rdi
	movq	%rax, (%r12,%rbx)
	call	malloc
	movq	8(%rsp), %rdi
	movq	%rax, (%rdi,%rbx)
	movq	%rbp, %rdi
	call	malloc
	movq	%rax, (%r15,%rbx)
	addq	$8, %rbx
	cmpq	%rbx, %r14
	jne	.L4
	pxor	%xmm2, %xmm2
	xorl	%edi, %edi
	movsd	.LC3(%rip), %xmm3
	cvtsi2sd	16(%rsp), %xmm2
	mulsd	%xmm3, %xmm2
.L30:
	pxor	%xmm0, %xmm0
	movapd	%xmm2, %xmm4
	movq	8(%rsp), %rax
	movapd	%xmm2, %xmm1
	movq	(%r12,%rdi,8), %rsi
	movq	(%r15,%rdi,8), %rdx
	cvtsi2sd	%edi, %xmm0
	movq	(%rax,%rdi,8), %rcx
	xorl	%eax, %eax
	mulsd	%xmm3, %xmm0
	subsd	%xmm0, %xmm4
	addsd	%xmm0, %xmm1
	movapd	%xmm4, %xmm0
	.p2align 4,,10
	.p2align 3
.L6:
	movq	$0, (%rsi,%rax,8)
	movsd	%xmm1, (%rcx,%rax,8)
	movsd	%xmm0, (%rdx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r13d
	jg	.L6
	addq	$1, %rdi
	cmpl	%edi, %r13d
	jg	.L30
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movl	28(%rsp), %eax
	xorl	%r11d, %r11d
	leaq	8(,%rax,8), %r9
.L24:
	movq	8(%rsp), %rax
	movq	(%r12,%r11,8), %rdi
	xorl	%ecx, %ecx
	movq	(%rax,%r11,8), %rsi
	.p2align 4,,10
	.p2align 3
.L11:
	movsd	(%rdi,%rcx), %xmm1
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L8:
	movq	(%r15,%rax,8), %rdx
	movsd	(%rdx,%rcx), %xmm0
	mulsd	(%rsi,%rax,8), %xmm0
	addq	$1, %rax
	cmpl	%eax, %r13d
	addsd	%xmm0, %xmm1
	jg	.L8
	movsd	%xmm1, (%rdi,%rcx)
	addq	$8, %rcx
	cmpq	%r9, %rcx
	jne	.L11
	addq	$1, %r11
	cmpl	%r11d, %r13d
	jg	.L24
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	cmpl	$11, 16(%rsp)
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC7(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	jle	.L54
	movq	-8(%r12,%rbp), %rdx
	pushq	%rcx
	.cfi_def_cfa_offset 152
	movl	$.LC6, %esi
	movl	36(%rsp), %ebx
	movq	(%r12), %rax
	movl	$1, %edi
	movsd	-8(%rdx,%rbp), %xmm2
	pushq	%rbx
	.cfi_def_cfa_offset 160
	pushq	%rbx
	.cfi_def_cfa_offset 168
	movl	%ebx, %r9d
	pushq	%rbx
	.cfi_def_cfa_offset 176
	movl	48(%rsp), %edx
	movl	%ebx, %r8d
	movsd	(%rax), %xmm1
	movl	%ebx, %ecx
	movl	$3, %eax
	call	__printf_chk
	addq	$32, %rsp
	.cfi_def_cfa_offset 144
.L20:
	cmpl	$0, 16(%rsp)
	jle	.L23
	movq	16(%rsp), %rax
	xorl	%ebx, %ebx
	subl	$1, %eax
	leaq	8(,%rax,8), %rbp
.L22:
	movq	(%r12,%rbx), %rdi
	call	free
	movq	8(%rsp), %rax
	movq	(%rax,%rbx), %rdi
	call	free
	movq	(%r15,%rbx), %rdi
	addq	$8, %rbx
	call	free
	cmpq	%rbp, %rbx
	jne	.L22
.L23:
	movq	%r12, %rdi
	call	free
	movq	8(%rsp), %rdi
	call	free
	movq	%r15, %rdi
	call	free
	xorl	%edi, %edi
	call	exit
.L53:
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC0, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L54:
	movl	$.LC8, %esi
	movl	$1, %edi
	movl	$1, %eax
	xorl	%ebx, %ebx
	call	__printf_chk
.L13:
	movq	8(%rsp), %rax
	xorl	%ebp, %ebp
	movq	(%rax,%rbx,8), %r14
	.p2align 4,,10
	.p2align 3
.L12:
	movsd	(%r14,%rbp,8), %xmm0
	movl	$.LC4, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %rbp
	call	__printf_chk
	cmpl	%ebp, %r13d
	jg	.L12
	movl	$10, %edi
	addq	$1, %rbx
	call	putchar
	cmpl	%ebx, %r13d
	jg	.L13
	movl	$.LC9, %edi
	xorl	%ebx, %ebx
	call	puts
.L16:
	movq	(%r15,%rbx,8), %r14
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L15:
	movsd	(%r14,%rbp,8), %xmm0
	movl	$.LC4, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %rbp
	call	__printf_chk
	cmpl	%ebp, %r13d
	jg	.L15
	movl	$10, %edi
	addq	$1, %rbx
	call	putchar
	cmpl	%ebx, %r13d
	jg	.L16
	movl	$.LC10, %edi
	xorl	%ebx, %ebx
	call	puts
.L19:
	movq	(%r12,%rbx,8), %r14
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L18:
	movsd	(%r14,%rbp,8), %xmm0
	movl	$.LC5, %esi
	movl	$1, %edi
	movl	$1, %eax
	addq	$1, %rbp
	call	__printf_chk
	cmpl	%ebp, %r13d
	jg	.L18
	movl	$10, %edi
	addq	$1, %rbx
	call	putchar
	cmpl	%ebx, %r13d
	jg	.L19
.L25:
	movl	$10, %edi
	call	putchar
	jmp	.L20
.L3:
	cmpq	$0, 8(%rsp)
	sete	%dl
	testq	%r12, %r12
	sete	%al
	orb	%al, %dl
	jne	.L28
	testq	%r15, %r15
	je	.L28
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movl	$.LC8, %esi
	pxor	%xmm0, %xmm0
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
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
	jmp	.L25
.L28:
	movl	$.LC1, %edi
	call	puts
	orl	$-1, %edi
	call	exit
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE11:
	.section	.text.startup
.LHOTE11:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	2576980378
	.long	1069128089
	.align 8
.LC7:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
