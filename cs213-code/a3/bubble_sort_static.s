.pos 0x100
	ld $i, r0	# r0 = address of i
	ld 0(r0), r0	# r0 = i
	ld $val, r1	# r1 = address of val
	ld (r1,r0,4), r0	# r0 = val[i]
	ld $j, r2	# r2 = address of j
	ld 0(r2), r2	# r2 = j
	ld (r1,r2,4), r2	# r2 = val[j]
	ld $i, r3	# r3 = address of i
	ld 0(r3), r3	# r3 = i
	st r2, (r1,r3,4)	# val[i] = val[j]
	ld $j, r3	# r3 = address of j
	ld 0(r3), r3	# r3 = j
	st r0, (r1, r3, 4)	# val[j] = t

	halt




.pos 0x200
i:	.long 0
j:	.long 0
val:	.long 0		# val[0]
	.long 0 	# val[1]
	.long 0		# val[2]
	.long 0		# val[3]