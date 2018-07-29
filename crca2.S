	.global crcInit
	.global crcFast
	
	.text
crcInit:
	movq $256, %rcx
Initloop1:	
	dec %rcx
        movq %rcx, %rax
	movq $8, %rdx
Initloop2:
	movq $0x80, %r8
	andq %rax, %r8
	shlb $1, %al
	movb %al, %r9b
	xorb (polynomial), %r9b
	test %r8, %r8
        cmovnz %r9, %rax
	dec %rdx
	test %rdx, %rdx
	jnz Initloop2
	
	movb %al, crcTable(%rcx)
	test %rcx, %rcx
	jnz Initloop1
	ret

crcFast://rsi=numBytes, rdi= buffer
	xorq %rcx, %rcx
	xorq %rax, %rax
crcLoop:
	movzbq (%rcx,%rdi,1), %r8
	xorq %rax, %r8
	movzbq crcTable(%r8), %rax
	inc %rcx
	cmp %rsi, %rcx
	jl crcLoop
	ret

	.data
crcTable:
	.rept 256
	.byte 0
	.endr
polynomial:
	.byte 0xD5
