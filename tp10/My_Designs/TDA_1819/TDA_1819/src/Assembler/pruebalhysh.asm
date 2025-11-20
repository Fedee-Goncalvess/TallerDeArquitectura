		.data
A:		.word	467
B:		.word	345
		.code
		daddi r1, r0, 1
		daddi r2, r0, 2
		sh r1 A
		sh r2 B
		lh r3 A
		lh r4 B
		halt
	