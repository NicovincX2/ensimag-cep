#TAG = sw

	.text

	lui x1, 0
	lw x2, ADDR1
	sw x1, 4(x2)
	lw x31, 4(x2)

	lui x1, 0
	addi x1, x1, -54594
	sw x1, 8(x2)
	lw x31, 8(x2)

	lui x1, 132314
	sw x1, 12(x2)
	lw x31, 12(x2)

	#max_cycle 300
	#pout_start
	#00000000
	#FFFF2ABE
	#000204DA
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F

