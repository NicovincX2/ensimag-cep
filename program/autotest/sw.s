#TAG = sw

	.text

	lui x1, 0
	la x2, ADDR1
	la x3, ADDR1
	addi x3, x3, 4
	sw x1, 4(x2)
	la x31, x3

	#max_cycle 300
	#pout_start
	#00000000	
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F

