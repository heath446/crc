.global crcInit
.global crcFast
.global crcTable

.text
	crcInit:
		mov	$0, %rdi	# Index i for outer loop (Dividend)
		mov	$8, %rsi	# Index j for inner loop (Bit)
		mov	$0, %al		# Remander char
		mov	$0, %cl		# Bit char
		jmp	.L3		#Jump to first outer loop

		.L4:
		  addq	$1, %rdi	# Increment i (Dividend)
		
		.L3:
		  cmpq	$256, %rdi
		  jb	.L1		# If i (Dividend) < 256 jump to inner loop
		  rep; ret		

		.L2:
		  subq	$1, %rsi	# Decrement j (Bit)

		.L1:	
		  cmpq	$0, %rsi	
		  jg	.L2		# If j (Bit) > 0, jump to .L2
		  mov	$8, %rsi	# Reset j (Bit) if condition false
		  jmp	.L4		# And jump back to outer loop
	

	crcFast:
		mov	$0, %rdi
		jmp	.L5

		.L6:
		  addq	$1, %rdi
		  
		.L5:
		  cmpq	$3, %rdi
		  jbe	.L6
		  rep; ret
.data
	crcTable:
		.rept 256
		.byte 0
		.endr
		

