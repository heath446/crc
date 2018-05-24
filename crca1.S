.global crcInit
.global crcFast
.global crcTable

.text
	crcInit:
		mov	$0, %rdi	# Index i for outer loop (Dividend)
		mov	$8, %rsi	# Index j for inner loop (Bit)
		mov	$0, %al		# Remander char
		mov	$0, %cl		# Bit char
		mov 	$crcTable, %rbx
		jmp	.L3		#Jump to first outer loop

		.L4:
		  addq	$1, %rdi	# Increment i (Dividend)
		
		.L3:
		  cmpq	$256, %rdi
		  jb	.L1		# If i (Dividend) < 256 jump to inner loop
		  rep; ret		

		.L2:
		  subq	$1, %rsi	# Decrement j (Bit)
		  mov	%al, (%rbx, %rdi, 1)

		.L1:	
		  cmpq	$0, %rsi	
		  jg	.test		# If j (Bit) > 0, jump to .L2
		  mov	$8, %rsi	# Reset j (Bit) if condition false
		  jmp	.L4		# And jump back to outer loop

		.test: 			
		  cmp	$0x80, %al	# Check remainder
		  je	.isTrue		
		  jmp	.isFalse

		.isTrue:
		  sal	$1, %al		# Shift
		  xor	%al, 0xD5 	# XOR
		  jmp	.L2		# Jump to Decrement

		.isFalse:
		  sal	$1, %al		# Shift
		  jmp	.L2		# Jump to Decrement

	crcFast:
					# rdi message
					# rsi nBytes
		mov	$0, %rdx	# data
		mov	$0, %rcx	# remainderA
		mov	$0, %rax	# byte
		mov	$crcTable, %rbx

		jmp	.L5

		.L6:
		  xor	%rcx, (%rdi, %rax, 1)
		  mov   (%rdi, %rax,1), %rdx
		  mov	(%rbx, %rdx, 1), %rcx		
		  addq	$1, %rdi
		  
		.L5:
		  cmpq	%rsi, %rax
		  jb	.L6
		  mov	%rcx, %rax 
		  rep; ret
.data
	crcTable:
		.rept 256
		.byte 0
		.endr
