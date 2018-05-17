.global crcInit
.global crcFast
.global crcTable

.text
	crcInit:
		mov	$0, %rax
		mov	$0, %rdi
		jmp	.L3

		.L4:
		  addq	$1, %rax
		
		.L3:
		  cmpq	$3, %rax
		  jbe	.L1
		  rep; ret

		.L2:
		  addq	$1, %rdi

		.L1:	
		  cmpq	$3, %rdi
		  jbe	.L2
		  mov	$0, %rdi
		  jmp	.L4
	

	crcFast:
		mov	$0, %rax
		jmp	.L5

		.L6:
		  addq	$1, %rax
		  
		.L5:
		  cmpq	$3, %rax
		  jbe	.L6
		  rep; ret
.data
	crcTable:
		.rept 256
		.byte 0
		.endr
		

