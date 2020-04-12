#TAG = sw

	.text

	lui x1, 0
	lw x2, ADDR1
	sw x1, 4(x2)
	lw x31, 4(x2)

	lui x1, 54594
	sw x1, 8(x2)
	lw x31, 8(x2)

	lui x1, 4143243
	sw x1, 12(x2)
	lw x31, 12(x2)

	#max_cycle 300
	#pout_start
	#00000000
	#0000D542
	#003F388B
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F

