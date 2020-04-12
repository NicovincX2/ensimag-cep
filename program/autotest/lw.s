#TAG = lw

	.text

	#Offset positif
	
	la x1, ADDR1
	lw x31, 0(x1)

	xor x1, x1
	la x1, ADDR1
	lw x31, 4(x1)

	xor x1, x1
	la x1, ADDR1
	lw x31, 8(x1)

	xor x1, x1
	la x1, ADDR1
	lw x31, 12(x1)

	#max_cycle 300
	#pout_start
	#F00FF00F
	#F00FF013
	#F00FF017
	#F00FF01B
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F

