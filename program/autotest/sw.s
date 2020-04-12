#TAG = sw

	.text

	lui x1, 0
	lw x2, 0(ADDR1)
	sw x1, 4(x2)
	la x31, 4(ADDR1)

	#max_cycle 300
	#pout_start
	#00000000	
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F

