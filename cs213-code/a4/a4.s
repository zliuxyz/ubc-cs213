.pos 0x1000
code:
	# v = s.x[i]
	ld $s, r0		# r0 = address of s
	ld $i, r1		# r1 = address of i
	ld 0x0(r1), r1		# r1 = i
	ld (r0, r1, 4), r1	# r1 = s.x[i]
	ld $v, r0		# r0 = address of v
	st r1, 0x0(r0)		# v = s.x[i]

	# v = s.y[i]
	ld $s, r0		# r0 = address of s
	ld 0x8(r0), r0		# r0 = s.y
	ld $i, r1		# r1 = address of i
	ld 0x0(r1), r1		# r1 = i
	ld (r0,r1,4), r0	# r0 = s.y[i]
	ld $v, r1		# r1 = address of v
	st r0, 0x0(r1)		# v = s.y[i]

	# v = s.z->x[i]
	ld $s, r0		# r0 = address of s
	ld 12(r0), r0		# r0 = s.z
	ld $i, r1		# r1 = address of i
	ld 0x0(r1), r1		# r1 = i
	ld (r0,r1,4), r0	# r0 = s.z->x[i]
	ld $v, r1		# r1 = address of v
	st r0, 0x0(r1)		# v = s.z->x[i]
	
	halt
	
	
.pos 0x2000
ststic:	
i:	.long 1
v:	.long 0
s:	.long 9             	# s.x[0]
	.long 0             	# s.x[1]
	.long 0x3000            # s.y
	.long 0x3008            # s.z


	
.pos 0x3000
heap0:
	.long 10             	# s.y[0]
	.long 0             	# s.y[1]

heap1:
	.long 0			# s.z -> x[0]
	.long 77		# s.z -> x[1]
	.long 0			# s.z -> y
	.long 0			# s.z -> z
